extends "res://Unit Scripts/Units.gd"

var isPlayer = false #can i use the class themselves? is enemy a child of player?


func _ready(): pass

func resetAnimation():
		pass
	
func move():
	#it needs to account for camera angle
	
	var loc = []
	loc = transform.origin + Vector3(0,0,1)
	if Grid.grid[loc[0]-0.5][loc[2]*-1-0.5][4] == 0: #check if pc is already on the square
		if Grid.grid[loc[0]-0.5][loc[2]*-1-0.5][5] == 0: #check if pc is already on the square
			loc[1] = Grid.grid[loc[0]-0.5][loc[2]*-1-0.5][2] + 0.635
			transform.origin = loc
	else: attack(get_node("../../../").getUnitByLoc(loc))

func isValidMove(loc): 
	for n in Grid.allowedTiles.size():
		if (Grid.allowedTiles[n][0] == (loc[0]-0.5)) and (Grid.allowedTiles[n][1] == (loc[2]*-1-0.5)): 
			return true
	
	return false
