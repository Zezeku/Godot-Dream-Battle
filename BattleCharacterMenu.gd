extends Control

signal moveCharacter
signal attackCharacter
signal waitCharacter
signal skillCharacter

#CommandMenu paths
var movePath = "Background/VSpacing/Main/LeftSideMenus/HBoxContainer/VBoxContainer2/MenuSelectCursorMove"
var attackPath ="Background/VSpacing/Main/LeftSideMenus/HBoxContainer/VBoxContainer2/MenuSelectCursorAttack"
var skillPath = "Background/VSpacing/Main/LeftSideMenus/HBoxContainer/VBoxContainer2/MenuSelectCursorSkill"
var itemPath = "Background/VSpacing/Main/LeftSideMenus/HBoxContainer/VBoxContainer2/MenuSelectCursorItem"
var waitPath = "Background/VSpacing/Main/LeftSideMenus/HBoxContainer/VBoxContainer2/MenuSelectCursorWait"

#Stats label paths
var defPath = "Background/VSpacing/Main/LeftSideMenus/HBoxContainer2/VBoxContainer2/Defense Label"
var strPath = "Background/VSpacing/Main/LeftSideMenus/HBoxContainer2/VBoxContainer2/Strength Label"
var hpPath = "Background/VSpacing/Main/LeftSideMenus/StatusBars/VBoxContainer/HP"
var mpPath = "Background/VSpacing/Main/LeftSideMenus/StatusBars/VBoxContainer/MP"
var expPath = "Background/VSpacing/Main/LeftSideMenus/StatusBars/VBoxContainer/EXP"

#ProgressBars paths
var hpBarPath = "Background/VSpacing/Main/LeftSideMenus/StatusBars/VBoxContainer2/HP Bar"

#this will come from activeUnit
#activeUnit will initialize, update, etc. all this does is display it for activeUnit
var mpBarPath = "Background/VSpacing/Main/LeftSideMenus/StatusBars/VBoxContainer2"

var expBarPath = "Background/VSpacing/Main/LeftSideMenus/StatusBars/VBoxContainer2/EXP Bar"


func _on_Wait_Button_pressed():
	emit_signal("waitCharacter")

func _on_Move_Button_pressed():
	emit_signal("moveCharacter")
	
func _on_Attack_Button_pressed():
	emit_signal("attackCharacter")
	
func _on_Skill_Button_pressed():
	emit_signal("skillCharacter")


func resetTurn():
	pass
	

func cycleMenuCursor(cursorCycle): #finding the current cursor loc should be its own function
	#will need it if i want to reset the cursor to the players last selected command
	#assuming they use controller to scroll, but then use button anyways
	
	
	var cycleMenu = [null, null, null, null, null]
	cycleMenu = [movePath, attackPath,skillPath,itemPath,waitPath]
	
	var cycleMenuCursor = [null, null, null, null ,null]
	cycleMenuCursor = [get_node(movePath).text, get_node(attackPath).text,get_node(skillPath).text,get_node(itemPath).text,get_node(waitPath).text]
	
	var cursorLoc = cycleMenuCursor.find("->     ")
	get_node(cycleMenu[cursorLoc]).text = ""
	
	if cursorCycle == "Cursor Up":
		if cursorLoc == 0:
			get_node(cycleMenu[4]).text = "->     "
		else:
			get_node(cycleMenu[cursorLoc - 1]).text = "->     "
	elif cursorCycle == "Cursor Down":
		if cursorLoc == 4:
			get_node(cycleMenu[0]).text = "->     "
		else:
			get_node(cycleMenu[cursorLoc + 1]).text = "->     "
	else:
		return "Problem"

func reset():
	if get_node(mpBarPath).get_child(2):
		get_node(mpBarPath).remove_child(get_node(mpBarPath).get_child(1))

func setStats(activeUnit):
	get_node(defPath).text = "Defense " + str(activeUnit.stats[activeUnit.DEF])
	get_node(strPath).text = "Strength " + str(activeUnit.stats[activeUnit.STR])
	
	get_node(hpPath).text = "HP " + str(activeUnit.stats[activeUnit.HP]) + " / " + str(activeUnit.stats[activeUnit.maxHP])
	get_node(hpBarPath).max_value = activeUnit.stats[activeUnit.maxHP]
	get_node(hpBarPath).value = activeUnit.stats[activeUnit.HP]
	
	get_node(mpPath).text = "MP " + str(activeUnit.stats[activeUnit.MP]) + " / " + str(activeUnit.stats[activeUnit.maxMP])
	get_node(mpBarPath).add_child(activeUnit.manaGUI)
	get_node(mpBarPath).move_child(activeUnit.manaGUI,1)
	#get_node(mpBarPath).value = activeUnit.MP
	
	get_node(expPath).text = "EXP " + str(activeUnit.stats[activeUnit.EXP]) + " / " + str(activeUnit.stats[activeUnit.maxEXP])
	get_node(expBarPath).max_value = activeUnit.stats[activeUnit.maxEXP]
	get_node(expBarPath).value = activeUnit.stats[activeUnit.EXP]





 # Replace with function body.
