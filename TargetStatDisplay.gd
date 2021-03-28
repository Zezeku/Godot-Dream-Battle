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

func setStats(isVisible, target):
	visible = isVisible
	if isVisible:
		get_node(hpPath).text = "HP " + str(target.stats[target.HP]) + " / " + str(target.stats[target.maxHP])
		get_node(mpPath).text = "MP " + str(target.stats[target.MP]) + " / " + str(target.stats[target.maxMP])
		get_node(expPath).text = "MP " + str(target.stats[target.EXP]) + " / " + str(target.stats[target.maxEXP])
		
		get_node(hpBarPath).max_value = target.stats[target.maxHP]
		get_node(mpBarPath).max_value = target.stats[target.maxMP]
		get_node(expBarPath).max_value = target.stats[target.maxEXP]
		
		get_node(hpBarPath).value = target.stats[target.HP]
		get_node(mpBarPath).value = target.stats[target.MP]
		get_node(expBarPath).value = target.stats[target.EXP]
		
		get_node(strPath).text = str(target.stats[target.STR])
		get_node(defPath).text = str(target.stats[target.DEF])
		get_node(movePath).text = str(target.stats[target.moveStat])
		get_node(spdPath).text = str(target.stats[target.SPD])
		get_node(rangePath).text = str(target.stats[target.atkRangeStat])

