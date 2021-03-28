extends "res://BattleFSM/State.gd"

func change_state(next_state):
	_fsm.change_to(next_state)
	

func enter(fsm:StateMachine):
	_fsm = fsm
	get_node("../../../UI/BattleCharacterMenu").hide()
	UI.setActiveWindow(true, Unit.activeUnit)


func inputResetTurn():
	if UI.moveCursorLoc()[0] == Unit.activeUnit.transform.origin[0] and UI.moveCursorLoc()[2] == Unit.activeUnit.transform.origin[2]:
		UI.setActiveWindow(false, null) 
		change_state("BattleMenuState")
	else:
		UI.moveCursor(Unit.activeUnit)
		UI.setTargetWindow(false, null)
		UI.setActiveWindow(true, Unit.activeUnit) 
		

func inputViewMode():
	UI.setTargetWindow(false, null)
	change_state("BattleMenuState")

func inputCursorUp():
	UI.attackCursor(UI.UP)
	checkForTarget()
func inputCursorDown():
	UI.attackCursor(UI.DOWN)
	checkForTarget()
func inputCursorLeft():
	UI.attackCursor(UI.LEFT)
	checkForTarget()
func inputCursorRight():
	UI.attackCursor(UI.RIGHT)
	checkForTarget()

func checkForTarget():
	var new_target = Unit.getUnitByLoc(UI.moveCursorLoc())
	
	if new_target == Unit.activeUnit :
		UI.setTargetWindow(false, null)
		UI.setActiveWindow(true, Unit.activeUnit)
	elif new_target != null :
		UI.setTargetWindow(true, new_target)
		UI.setActiveWindow(false, null)
	else: 
		UI.setTargetWindow(false, null)
		UI.setActiveWindow(false, null)
		
