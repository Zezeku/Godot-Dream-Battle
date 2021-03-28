extends "res://BattleFSM/State.gd"

func enter(fsm:StateMachine):
	_fsm = fsm
	UI.resetTurn(Unit.activeUnit)
	UI.moveCursor(Unit.activeUnit)
	Grid.resetTurn()
	

func inputResetTurn():
	Unit.activeUnit.resetMove(Unit.activeUnitStart)
	UI.moveCursor(Unit.activeUnit)
	UI.moveButton().disabled = false

func inputViewMode():
	change_state("ViewState")

func change_state(next_state):
	_fsm.change_to(next_state)
	

func _on_UI_moveCharacter():
	
	change_state("MoveState")

func _on_UI_attackCharacter():
	Unit.activeUnit.activeSkill = Unit.activeUnit.jobData.skillList[0]
	print(Unit.activeUnit.activeSkill.skill_name)
	change_state("ActState")

func _on_UI_waitCharacter():
	Grid.swapUnitOn(Unit.setGridPos(), Unit.activeUnit.isPlayer)
	change_state("WaitState")

func _on_UI_skillCharacter():
	change_state("SkillState")
