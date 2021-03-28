extends CanvasLayer

signal moveCharacter
signal attackCharacter
signal waitCharacter
signal skillCharacter

onready var target_window = load("res://TargetStatDisplay.tscn").instance()
onready var active_window = load("res://ActiveStatDisplay.tscn").instance()
onready var combatWindow = load("res://CombatWindow.tscn").instance()
onready var character_menu = load("res://BattleCharacterMenu.tscn").instance() #load character battle menu on start

enum { UP = 0, LEFT = 1, DOWN = 2, RIGHT = 3}

func _ready():
	add_child(target_window)
	add_child(active_window)
	add_child(combatWindow)
	add_child(character_menu)
	#add the loaded scene to UI node, ie so that it shows up and on top of screen
	#Note: i have to use the node name to use node fucntions. character menu is just the loaded instance
	#this can be condensed but keeping in case the variable helps for future cases
	$BattleCharacterMenu.connect("moveCharacter", self, "moveCharacter") #listen for move button signal
	$BattleCharacterMenu.connect("attackCharacter", self, "attackCharacter")
	$BattleCharacterMenu.connect("waitCharacter", self, "waitCharacter")
	$BattleCharacterMenu.connect("skillCharacter", self, "skillCharacter")
	

func moveCharacter():
	emit_signal("moveCharacter")

func attackCharacter():
	emit_signal("attackCharacter")

func waitCharacter():
	emit_signal("waitCharacter")

func skillCharacter():
	emit_signal("skillCharacter")


func moveCursorLoc():
	return $MoveCursor.transform.origin

func moveButton():
	return get_node("BattleCharacterMenu/Background/VSpacing/Main/LeftSideMenus/HBoxContainer/VBoxContainer/Move Button")

func attackButton():
	return get_node("BattleCharacterMenu/Background/VSpacing/Main/LeftSideMenus/HBoxContainer/VBoxContainer/Attack Button")

func skillButton():
	return get_node("BattleCharacterMenu/Background/VSpacing/Main/LeftSideMenus/HBoxContainer/VBoxContainer/Skill Button")

func moveCharacterTiles(activeUnit):
	#$MoveCursor.show()
	#$MoveCursor.transform.origin = activeUnit.transform.origin + Vector3(0, 1.15, 0)
	$BattleCharacterMenu.hide()

func attackCharacterTiles(activeUnit):
	#$MoveCursor.show()
	#$MoveCursor.transform.origin = activeUnit.transform.origin + Vector3(0, 1.15, 0)
	$BattleCharacterMenu.hide()

func resetTurn(activeUnit):
	$MoveCursor.show()
	$BattleCharacterMenu.reset()
	$BattleCharacterMenu.show()
	setStats(activeUnit)

func setBattleMenu(isVisible):
	if isVisible:$BattleCharacterMenu.show()
	else: $BattleCharacterMenu.hide()

func setTargetWindow(isVisible, target):
	$TargetDisplayMenu.setStats(isVisible, target)

func setActiveWindow(isVisible, activeChar):
	$ActiveDisplayMenu.setStats(isVisible, activeChar)

func setCombatWindow(isVisible):
	$CombatWindow.visible = isVisible

func calcCombatWindow(damage):
	$CombatWindow.setDamageCalc(damage)

func moveCursor(activeUnit): #follows character
	$MoveCursor.transform.origin = activeUnit.transform.origin + Vector3(0, 2*activeUnit.spriteOffset, 0)


func attackCursor(input):
	var loc = []
	var translate = [Vector3(-1,0,0), Vector3(0,0,1), Vector3(1,0,0), Vector3(0,0,-1)]
	
	loc = $MoveCursor.transform.origin + translate[(get_node("../CameraNode").cam_dir + input) % translate.size()]
	if loc[0] >=0 and loc[0] <= 10 and loc[2] <= 0 and loc[2] >= -10:
		loc[1] = get_node("../Grid").grid[loc[0]-0.5][-1*loc[2]-0.5][2] + 1.8
	$MoveCursor.transform.origin = loc

func setCursorHeight(new_target):
	# same equation as attackCursor ecept using target to get height instead of grid
	# and scale by sprites offset os that cursor sits above a sprites head
	#(height +  1.8) * offseet
	$MoveCursor.transform.origin[1] = new_target.translation[1] + 1.8 * new_target.spriteOffset
	

func setStats(activeUnit):
	$BattleCharacterMenu.setStats(activeUnit)
	

func showConfirmWindow():
	get_node("GUI/ConfirmWindow").show()

func hideConfirmWindow():
	get_node("GUI/ConfirmWindow").hide()
