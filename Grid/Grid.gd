extends Node

var grid = []


const MAP_LENGTH = 10
const MAP_WIDTH = 10

#character should own these variables
var allowedTiles= [] #grid will have a local subset of this for move indicators

# Called when the node enters the scene tree for the first time.
func _ready():
	create_grid()
	fill_grid() 
	
	

func attackChracterTiles(activeUnit, atk_range):
	
	var indexX = activeUnit.transform.origin[0] - 0.5
	var indexZ = -1 * activeUnit.transform.origin[2] - 0.5
	
	allowedTiles= [] #always reset on a range call
	FindRange(allowedTiles,indexX, indexZ, activeUnit.isPlayer, atk_range)
	
	var attackIndicator = []
	attackIndicator.resize(allowedTiles.size())
	for n in attackIndicator.size():
		attackIndicator[n] = load("res://Grid/AttackIndicator.tscn").instance()
		attackIndicator[n].set_name("attackIndicator" + str(n))
		add_child(attackIndicator[n])
		var loc_x = grid[allowedTiles[n][0]][allowedTiles[n][1]][0]
		var loc_y = grid[allowedTiles[n][0]][allowedTiles[n][1]][2] + 0.02
		var loc_z = grid[allowedTiles[n][0]][allowedTiles[n][1]][1]
		get_node(attackIndicator[n].get_name()).transform.origin = Vector3(loc_x,loc_y,loc_z)
	#	# this is crucial. Godot default child node name to scene name, not variable name
	#	# then it uses that String name as the reference for function calls like get_node

func moveCharacterTiles(activeUnit):
	
	
	
	var indexX = activeUnit.transform.origin[0] - 0.5
	var indexZ = -1 * activeUnit.transform.origin[2] - 0.5
	
	allowedTiles= [] #always reset on a range call
	
	
	FindRange(allowedTiles,indexX, indexZ, activeUnit.isPlayer, activeUnit.stats[activeUnit.moveStat])
	allowedTiles.remove(0) #Break anything? keeps move indicator showing under initial position
	
	var moveIndicator = []
	moveIndicator.resize(allowedTiles.size())
	for n in moveIndicator.size():
		if grid[allowedTiles[n][0]][allowedTiles[n][1]][5] == 1:
			moveIndicator[n] = load("res://Grid/AttackIndicator.tscn").instance()
		else:
			moveIndicator[n] = load("res://Grid/MoveIndicator.tscn").instance() #create conditional where indicator loaded depends on unit type on grid location
		moveIndicator[n].set_name("moveIndicator" + str(n))
		add_child(moveIndicator[n])
		var loc_x = grid[allowedTiles[n][0]][allowedTiles[n][1]][0]
		var loc_y = grid[allowedTiles[n][0]][allowedTiles[n][1]][2] + 0.05
		var loc_z = grid[allowedTiles[n][0]][allowedTiles[n][1]][1]
		get_node(moveIndicator[n].get_name()).transform.origin = Vector3(loc_x,loc_y,loc_z)
	#	# this is crucial. Godot default child node name to scene name, not variable name
	#	# then it uses that String name as the reference for function calls like get_node
	
	var ActiveCharacterIndicator = load("res://Grid/ActiveCharacterIndicator.tscn").instance()
	add_child(ActiveCharacterIndicator)
	$ActiveCharacterIndicator.transform.origin = activeUnit.transform.origin
	$ActiveCharacterIndicator.translate(Vector3(0, -0.6/0.01 , 0)) 
	#this translate is based on the tiles scale!!!
	#since it y is super small (0.01), to translate .5 in global world, we have to do -0.5/0.01 = -61 !!
	# a unit move = 1/0.01 = 100

func FindRange(allowedTiles, indexX, indexZ, isPlayer, count):
	
	if indexX >=MAP_LENGTH or indexZ >= MAP_WIDTH or indexX < 0 or indexZ < 0 : #map size
		return
	
	if isPlayer:
		if count < 0 or grid[indexX][indexZ][3] == 0:
				return
		elif grid[indexX][indexZ][5] == 1 :
			if !duplicateTile(allowedTiles, indexX, indexZ):
				allowedTiles.resize(allowedTiles.size()+1)
				allowedTiles[allowedTiles.size()-1] = [indexX, indexZ]
				return
			else: return
	else:
		if count < 0 or grid[indexX][indexZ][3] == 0 or grid[indexX][indexZ][4] == 1 : 
			return
	
	if !duplicateTile(allowedTiles, indexX, indexZ):
		allowedTiles.resize(allowedTiles.size()+1)
		allowedTiles[allowedTiles.size()-1] = [indexX, indexZ]
	
	FindRange(allowedTiles,indexX+1, indexZ, isPlayer, count - 1)
	FindRange(allowedTiles,indexX-1, indexZ, isPlayer, count - 1)
	FindRange(allowedTiles,indexX, indexZ+1, isPlayer, count - 1)
	FindRange(allowedTiles,indexX, indexZ-1, isPlayer, count - 1)

func duplicateTile(allowedTiles, indexX, indexZ):\
	#checking if tile is already in the list
	#godot does not have built in function for arrays with array elements
	for n in allowedTiles.size():
		if allowedTiles[n] == [indexX, indexZ]:
			return true
	return false

func swapUnitOn(index, isPlayer):
	# index comes from turn queue
	# index[0], index[1] are x,z coord of active unit start pos
	# index[2], index[3] are x,z coord of active unit new pos
	if isPlayer:
		grid[index[0]][index[1]][4] = 0
		grid[index[2]][index[3]][4] = 1
	else:
		grid[index[0]][index[1]][5] = 0
		grid[index[2]][index[3]][5] = 1

func resetTurn():
	for n in self.get_children(): #needs looked at later, what if other children besides tiles?
		self.remove_child(n)
		n.queue_free()

func create_grid():
	grid.resize(MAP_WIDTH)
	for n in MAP_WIDTH:
		grid[n] = []
		grid[n].resize(MAP_LENGTH)

func fill_grid():
	for n in MAP_WIDTH:
		for m in MAP_LENGTH:
			grid[n][m] = [1 * (n+0.5), -1 * (m+0.5), 1.0, 1.0, 0.0, 0.0, "Plain"]
	#grid[ x coord, z coord, y coord ie Height, Exists, AllyOn, EnemyOn, Terrain ]
	
	#allys on
	grid[6][0][4] = 1
	grid[5][0][4] = 1
	grid[4][0][4] = 1
	#grid[4][3][4] = 1
	
	#enemys on
	grid[1][4][5] = 1
	grid[8][4][5] = 1
	grid[8][8][5] = 1 
	
	#platform
	grid[2][0][2] = 1.5
	grid[3][0][2] = 1.5
	grid[4][0][2] = 1.5
	grid[5][0][2] = 1.5
	grid[6][0][2] = 1.5
	grid[7][0][2] = 1.5
	grid[2][1][2] = 1.5
	grid[3][1][2] = 1.5
	grid[4][1][2] = 1.5
	grid[5][1][2] = 1.5
	grid[6][1][2] = 1.5
	grid[7][1][2] = 1.5
	
	#wall
	grid[2][4][3] = 0
	grid[3][4][3] = 0
	grid[4][4][3] = 0
	grid[5][4][3] = 0
	grid[6][4][3] = 0
	grid[7][4][3] = 0


