extends "res://BattleFSM/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm
	Unit.newActive(TurnQueue.new_turn())
	
	if Unit.activeUnit.skillEffects.size() > 0:
		Unit.activeUnit.skillEffects[0].update()
	
	UI.moveButton().disabled = false
	UI.attackButton().disabled = false
	UI.skillButton().disabled = false
	
	if Unit.activeUnit.isPlayer: #will go away once enemies redone to be like automated player
		if Unit.activeUnit.jobData.skillList.size() <= 1 :
			UI.skillButton().disabled = true
	
	if Unit.activeUnit.HP <= 0:
		change_state("EndTurnState") #go to next player
	
	elif Unit.activeUnit.isPlayer:
		change_state("BattleMenuState") #open up menu
	
	else:#ENEMY AI TURN 
		UI.moveCharacterTiles(Unit.activeUnit)
		Unit.activeUnit.move()
		Grid.swapUnitOn(Unit.setGridPos(), Unit.activeUnit.isPlayer)
		change_state("NewTurnState")

func change_state(next_state):
	_fsm.change_to(next_state)
	
func inputResetTurn():
	change_state("BattleMenuState")

func enemyInput():
	var ev = InputEventAction.new()
	ev.action = "Enter"
	ev.pressed = true
	Input.parse_input_event(ev)
