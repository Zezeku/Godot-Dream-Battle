extends Control



#Stats values
var hpPath = "Background/VSpacing/Main/LeftSideStats/VBoxContainer/StatusBars/VBoxContainer/HP"
var mpPath = "Background/VSpacing/Main/LeftSideStats/VBoxContainer/StatusBars/VBoxContainer/MP"
var expPath = "Background/VSpacing/Main/LeftSideStats/VBoxContainer/StatusBars/VBoxContainer/EXP"

var strPath = "Background/VSpacing/Main/LeftSideStats/VBoxContainer/StatsWindow2/VBoxContainer/HBoxContainer/VBoxContainer3/AttackLabel"
var defPath ="Background/VSpacing/Main/LeftSideStats/VBoxContainer/StatsWindow2/VBoxContainer/HBoxContainer/VBoxContainer3/DefenseLabel"

var movePath = "Background/VSpacing/Main/RightSideStats/StatsWindow/VBoxContainer/HBoxContainer/VBoxContainer3/Move Stat"
var spdPath = "Background/VSpacing/Main/RightSideStats/StatsWindow/VBoxContainer/HBoxContainer/VBoxContainer3/Speed Stat"
var rangePath  = "Background/VSpacing/Main/RightSideStats/StatsWindow/VBoxContainer/HBoxContainer/VBoxContainer3/Range Stat"

#progress bars
var hpBarPath = "Background/VSpacing/Main/LeftSideStats/VBoxContainer/StatusBars/VBoxContainer2/HP Bar"
var mpBarPath = "Background/VSpacing/Main/LeftSideStats/VBoxContainer/StatusBars/VBoxContainer2/MP Bar"
var expBarPath = "Background/VSpacing/Main/LeftSideStats/VBoxContainer/StatusBars/VBoxContainer2/EXP Bar"



func _ready():
	visible = false

func setStats(isVisible, activeChar):
	visible = isVisible
	if isVisible:
		get_node(hpPath).text = "HP " + str(activeChar.stats[activeChar.HP]) + " / " + str(activeChar.stats[activeChar.maxHP])
		get_node(mpPath).text = "MP " + str(activeChar.stats[activeChar.MP]) + " / " + str(activeChar.stats[activeChar.maxMP])
		get_node(expPath).text = "MP " + str(activeChar.stats[activeChar.EXP]) + " / " + str(activeChar.stats[activeChar.maxEXP])
		
		get_node(hpBarPath).max_value = activeChar.stats[activeChar.maxHP]
		get_node(mpBarPath).max_value = activeChar.stats[activeChar.maxMP]
		get_node(expBarPath).max_value = activeChar.stats[activeChar.maxEXP]
		
		get_node(hpBarPath).value = activeChar.stats[activeChar.HP]
		get_node(mpBarPath).value = activeChar.stats[activeChar.MP]
		get_node(expBarPath).value = activeChar.stats[activeChar.EXP]
		
		get_node(strPath).text = str(activeChar.stats[activeChar.STR])
		get_node(defPath).text = str(activeChar.stats[activeChar.DEF])
		get_node(movePath).text = str(activeChar.stats[activeChar.moveStat])
		get_node(spdPath).text = str(activeChar.stats[activeChar.SPD])
		get_node(rangePath).text = str(activeChar.stats[activeChar.atkRangeStat])
		

#var maxHP = 20
#var HP = 15
#var maxMP = 10
#var MP = 5
#var maxEXP = 100
#var EXP = 0

#var STR = 10
#var DEF = 8
#var SPD = 12
#var moveStat = 4
#var atkRangeStat =  1
