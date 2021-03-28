extends Resource

var floatingText = preload("res://FloatingText.tscn")

class_name DamageEffect


func pre_execute(source, target, skill):
	
	var heightDiff = int((target.transform.origin[1] - target.spriteOffset) - (source.transform.origin[1] - source.spriteOffset))
	var sideMult
	
	if source.direction == target.direction:
		sideMult = 1.25
	elif (source.direction + 2 ) % 4 == target.direction:
		sideMult = 0.85
	else:
		sideMult = 1
	
	var damageCalc = int(max(0, source.stats[source.STR] * skill.multiplier - target.stats[target.DEF]))
	
	return [max(0,damageCalc), sideMult, heightDiff]

func execute(source, target, skill):
	
	var damageCalc = pre_execute(source, target, skill)[0]
	
	var text = floatingText.instance()
	text.amount = damageCalc
	target.add_child(text)
	
	target.stats[target.HP] -= damageCalc
	if target.stats[target.HP] <= 0: target.unitDeath()
	
	


func update(source, target, skill):
	pass
	
