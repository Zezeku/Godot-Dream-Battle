extends Control


func initializeManaType(maxSP):
	self.max_value = maxSP
	self.value = maxSP

func updateMana(unit, manaCost):
	self.value -= manaCost
