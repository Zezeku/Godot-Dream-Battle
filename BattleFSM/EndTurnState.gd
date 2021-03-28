extends "res://BattleFSM/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm
	change_state("NewTurnState")

func change_state(next_state):
	_fsm.change_to(next_state)
	
