extends "res://BattleFSM/State.gd"


func change_state(next_state):
	_fsm.change_to(next_state)
	

func enter(fsm:StateMachine):
	_fsm = fsm
	UI.attackCharacterTiles(Unit.activeUnit)
	Grid.attackChracterTiles(Unit.activeUnit, Unit.activeUnit.activeSkill.damageRange)
	
	UI.setActiveWindow(true, Unit.activeUnit) 
	UI.setTargetWindow(false, Unit.activeUnit)

func inputResetTurn():
	
	if UI.moveCursorLoc()[0] == Unit.activeUnit.transform.origin[0] and UI.moveCursorLoc()[2] == Unit.activeUnit.transform.origin[2]:
			UI.setActiveWindow(false, null) 
			UI.setTargetWindow(false, null) 
			change_state("BattleMenuState")
	
	else: 
		UI.moveCursor(Unit.activeUnit)
		UI.setTargetWindow(false, null)
		UI.setActiveWindow(true, Unit.activeUnit) 
	

func inputEnter():
	if Unit.activeUnit.selectAttack(UI.moveCursorLoc()):
		change_state("ConfirmActState")
	else: pass

func mouseButtonClick():
	inputEnter()

func inputCursorUp():
	UI.attackCursor(UI.UP)
	Unit.activeUnit.attackAnimation(UI.moveCursorLoc())
	checkForTarget()
func inputCursorDown():
	UI.attackCursor(UI.DOWN)
	Unit.activeUnit.attackAnimation(UI.moveCursorLoc())
	checkForTarget()
func inputCursorLeft():
	UI.attackCursor(UI.LEFT)
	Unit.activeUnit.attackAnimation(UI.moveCursorLoc())
	checkForTarget()
func inputCursorRight():
	UI.attackCursor(UI.RIGHT)
	Unit.activeUnit.attackAnimation(UI.moveCursorLoc())
	checkForTarget()

func checkForTarget():
	var new_target = Unit.getUnitByLoc(UI.moveCursorLoc())
	
	if new_target != null :
		UI.setTargetWindow(true, new_target)
		UI.setCursorHeight(new_target)
	else: 
		UI.setTargetWindow(false, null)
