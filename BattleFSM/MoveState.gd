extends "res://BattleFSM/State.gd"

func enter(fsm:StateMachine):
	_fsm = fsm
	UI.moveCharacterTiles(Unit.activeUnit)
	Grid.moveCharacterTiles(Unit.activeUnit) 

func change_state(next_state):
	_fsm.change_to(next_state)
	
func inputResetTurn():
	Unit.activeUnit.resetMove(Unit.activeUnitStart)
	UI.moveButton().disabled = false
	_fsm.previous_state()

func inputCursorUp():
	Unit.activeUnit.move(Unit.activeUnit.UP)
	UI.moveCursor(Unit.activeUnit)
func inputCursorDown():
	Unit.activeUnit.move(Unit.activeUnit.DOWN)
	UI.moveCursor(Unit.activeUnit)
func inputCursorLeft():
	Unit.activeUnit.move(Unit.activeUnit.LEFT)
	UI.moveCursor(Unit.activeUnit)
func inputCursorRight():
	Unit.activeUnit.move(Unit.activeUnit.RIGHT)
	UI.moveCursor(Unit.activeUnit)

func inputEnter():
	if Unit.activeUnit.endMove():
		Unit.activeUnit.setAnimation()
		UI.moveButton().disabled = true
		change_state("BattleMenuState")
	else: pass

func mouseButtonClick():
	inputEnter()
