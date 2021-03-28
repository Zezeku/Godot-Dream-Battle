extends Node

class_name StateMachine

var state: Object
var history = []

# Called when the node enters the scene tree for the first time.
func _ready():
	state = get_child(0).get_child(0) #FSM -> State -> NewTurnState
	_enter_state()

func _enter_state():
	state.enter(self)

func change_to(new_state):
	history.append(state.name)
	state = state.get_parent().get_node(new_state)
	_enter_state()

func previous_state():
	if history.size() > 0 :
		state = state.get_parent().get_node(history.pop_back())
		_enter_state()
	

func _input(event):
	
	if event.is_action_pressed("Reset Turn") and state.has_method("inputResetTurn"):
		state.inputResetTurn()
	if event.is_action_pressed("Enter") and state.has_method("inputEnter"):
		state.inputEnter()
	if event.is_action_pressed("Cursor Up") and state.has_method("inputCursorUp"):
		state.inputCursorUp()
	if event.is_action_pressed("Cursor Down") and state.has_method("inputCursorDown"):
		state.inputCursorDown()
	if event.is_action_pressed("Cursor Right") and state.has_method("inputCursorRight"):
		state.inputCursorRight()
	if event.is_action_pressed("Cursor Left") and state.has_method("inputCursorLeft"):
		state.inputCursorLeft()
	if event.is_action_pressed("Rotate Right") and state.has_method("inputRotateRight"):
		state.inputRotateRight()
	if event.is_action_pressed("Rotate Left") and state.has_method("inputRotateLeft"):
		state.inputRotateLeft()
	if event is InputEventMouseButton and state.has_method("mouseButtonClick"):
		state.mouseButtonClick()
	if event.is_action_pressed("View Mode") and state.has_method("inputViewMode"):\
		state.inputViewMode()
	if event.is_action_pressed("Camera Up") and state.has_method("CameraUp"):\
		state.CameraUp()
