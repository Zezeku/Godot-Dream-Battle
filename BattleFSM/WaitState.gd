extends "res://BattleFSM/State.gd"

func enter(fsm:StateMachine):
	_fsm = fsm
	UI.setBattleMenu(false)
	

#enter should display diretional arrows, then wait for input
#need to implement inputs to choose ending direction
#then current enter state goes into enter input

func inputEnter():
	UI.resetTurn(Unit.activeUnit)
	UI.moveCursor(Unit.activeUnit)
	Grid.resetTurn()
	Grid.swapUnitOn(Unit.setGridPos(), Unit.activeUnit.isPlayer)
	change_state("EndTurnState")

#need escape button, how to check if allowed?

func mouseButtonClick():
	inputEnter()

func inputCursorUp():
	Unit.activeUnit.waitAnimation(Unit.UP)
func inputCursorRight():
	Unit.activeUnit.waitAnimation(Unit.RIGHT)
func inputCursorDown():
	Unit.activeUnit.waitAnimation(Unit.DOWN)
func inputCursorLeft():
	Unit.activeUnit.waitAnimation(Unit.LEFT)



func change_state(next_state):
	_fsm.change_to(next_state)
	
