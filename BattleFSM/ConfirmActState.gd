extends "res://BattleFSM/State.gd"

func change_state(next_state):
	_fsm.change_to(next_state)

func enter(fsm:StateMachine):
	_fsm = fsm
	UI.setCombatWindow(true)
	var attackSide = null
	
	#pass in directions of unit and target
	#UI.calcCombatWindow(Unit.activeUnit.damageCalc(Unit.getUnitByLoc(UI.moveCursorLoc())))
	
	#here is issue. i can only send in single target based on cursor, and the player
	#think of better solutions. different sets of targets? how to cycle?
	#a seperate targeting system that can be used by character and sent to jobData?
	#or used by skills based on units location and then lets plater choose from that set?
	#UI.calcCombatWindow(Unit.activeUnit.activeSkill.pre_execute(Unit.activeUnit, Unit.getUnitByLoc(UI.moveCursorLoc())))

func inputResetTurn():
	UI.setCombatWindow(false)
	change_state("ActState")

func inputEnter():
	
	#Unit.executeActive(UI.moveCursorLoc)
	Unit.activeUnit.activeSkill.execute(Unit.activeUnit, Unit.getUnitByLoc(UI.moveCursorLoc()))
	
	UI.attackButton().disabled = true
	UI.skillButton().disabled = true
	
	UI.setCombatWindow(false)
	UI.setActiveWindow(false, null) 
	UI.setTargetWindow(false, null) 
	UI.moveCursor(Unit.activeUnit)
	
	if UI.moveButton().disabled == false:
		change_state("BattleMenuState")
	else:
		change_state("WaitState")
	
#func mouseButtonClick():
	#inputEnter()

