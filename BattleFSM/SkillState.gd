extends "res://BattleFSM/State.gd"

func change_state(next_state):
	_fsm.change_to(next_state)
	
func enter(fsm:StateMachine):
	_fsm = fsm
	print("enter skill state")

func inputResetTurn():
	pass

func inputEnter():
	pass


func mouseButtonClick():
	pass

func inputCursorUp():
	pass
func inputCursorDown():
	pass
func inputCursorLeft():
	pass
func inputCursorRight():
	pass
func checkForTarget():
	pass
