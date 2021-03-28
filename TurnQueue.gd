extends Node


var turnList
var index = 0

func _ready():
	turnList = get_node("../UnitManager").unitList
	index = turnList.size() - 1
	#algorithm for turnList(unitList)


func new_turn():
	index = (index + 1) % turnList.size()
	return  turnList[index]
	
