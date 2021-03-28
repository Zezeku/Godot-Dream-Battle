extends Resource

class_name ManaType

export(String) var mana_type
export(int) var maxMana

export(PackedScene) var GUI

func initialize(unit):
	unit.manaType = self
	unit.manaGUI = GUI.instance()
	unit.manaGUI.initializeManaType(unit.stats[unit.maxMP])

func updateMana(unit, manaCost): #this steps seems unneccessary. However it may prove useful for checking later
	#can i give the manatype resources custom scripts?
	unit.stats[unit.MP]  -= manaCost
	unit.manaGUI.updateMana(unit, manaCost)
	
