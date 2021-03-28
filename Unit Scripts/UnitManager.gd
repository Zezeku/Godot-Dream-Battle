extends Node

var unitList
var activeUnit

#values at start of turn. store them to simplify reset buttons
var activeUnitStart = []
var activeUnitDirection = null

onready var newPlayer = load("res://Unit Scripts/Player Scripts/PlayerX.tscn")


enum { UP = 0, LEFT = 1, DOWN = 2, RIGHT = 3}
var aniMove = ["Move_Up", "Move_Left","Move_Down","Move_Right"]
var aniIdle = ["Idle_Up", "Idle_Left","Idle_Down","Idle_Right"]

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#generate pcs
	for childIndex in 3:
		$Units/Player.add_child(newPlayer.instance())
		$Units/Player.get_child(childIndex).set_name("Player " + str(childIndex))
		$Units/Player.get_child(childIndex).transform.origin = Vector3(6.5 - childIndex, 2.1, -0.5)
	
	#set jobs
	$Units/Player.get_child(0).initializeStats(load("res://Job System/Jobs/Rogue.tres")) 
	$Units/Player.get_child(1).initializeStats(load("res://Job System/Jobs/Soldier.tres")) 
	$Units/Player.get_child(2).initializeStats(load("res://Job System/Jobs/Soldier.tres")) 
	
	
	#creat list for combat turns
	unitList = get_node("Units/Player").get_children() + get_node("Units/Enemy").get_children()
	

func newActive(newActiveUnit):
	activeUnit = newActiveUnit
	activeUnitStart = newActiveUnit.transform.origin
	activeUnitDirection = newActiveUnit.direction

func setGridPos():
	var indexX1 = activeUnitStart[0] - 0.5
	var indexZ1 = -1 * activeUnitStart[2] - 0.5
	var indexX2 = activeUnit.transform.origin[0] - 0.5
	var indexZ2 = -1 * activeUnit.transform.origin[2] - 0.5
	return [indexX1, indexZ1, indexX2, indexZ2]

func getUnitByLoc(curLoc): #move this to units?
	for n in unitList.size():
		if unitList[n].transform.origin[0] == curLoc[0] and unitList[n].transform.origin[2] == curLoc[2]:
			return unitList[n]
		
	return null

func rotate_right():
	activeUnitDirection  = (activeUnitDirection + 3) % 4
	for n in unitList.size():
		unitList[n].direction = (unitList[n].direction + 3) % 4
		if unitList[n].isPlayer:
			unitList[n].sprite.animation = aniIdle[unitList[n].direction]
	#rotate all units right

func rotate_left():
	activeUnitDirection  = (activeUnitDirection + 1) % 4
	for n in unitList.size():
		unitList[n].direction = (unitList[n].direction + 1) % 4
		if unitList[n].isPlayer:
			unitList[n].sprite.animation = aniIdle[unitList[n].direction]
	#rotate all units left
