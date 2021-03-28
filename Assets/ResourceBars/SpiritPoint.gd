extends Control

#these arent working
onready var spiritFillTexture = preload("res://Assets/ResourceBars/SpiritBarAnim.tres")
onready var spiritBackTexture = preload("res://Assets/ResourceBars/SpiritBarBack.png")

func initializeManaType(maxSP):
	for sp in maxSP:
		var newSP = load("res://Assets/ResourceBars/SpiritFill.tscn").instance()
		newSP.set_name("SpiritFill" + str(sp))
		self.add_child(newSP)
		#if sp == (maxSP-1): #test to change to used SP, this solution works
		#	$HBoxContainer.get_child($HBoxContainer.get_child_count()-1).texture = load("res://Assets/ResourceBars/SpiritBarBack.png")

func updateMana(unit, manaCost): #pass in unit current MP to find where to start
	for sp in manaCost:
		self.get_child((unit.stats[unit.MP]+manaCost)-(1+sp)).texture = load("res://Assets/ResourceBars/SpiritBarBack.png")
