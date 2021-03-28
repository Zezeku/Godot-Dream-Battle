extends Control


func initializeManaType(maxMP):
	self.max_value = maxMP
	self.value = maxMP

func updateMana(unit, manaCost):
	self.value -= manaCost
