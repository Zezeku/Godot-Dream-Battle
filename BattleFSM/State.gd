extends Node

onready var Camera = get_node("../../../CameraNode")
onready var TurnQueue = get_node("../../../TurnQueue")
onready var Grid = get_node("../../../Grid")
onready var UI = get_node("../../../UI")
onready var Unit = get_node("../../../UnitManager")

var _fsm: StateMachine

func enter(fsm:StateMachine):
	_fsm = fsm

func inputRotateRight():
	Camera.rotate_right()


func inputRotateLeft():
	Camera.rotate_left()

func CameraUp():
	Camera.CameraUp()
