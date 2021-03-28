extends Spatial

var floatingText = preload("res://FloatingText.tscn")

enum { UP = 0, LEFT = 1, DOWN = 2, RIGHT = 3}
var aniMove = ["Move_Up", "Move_Left","Move_Down","Move_Right"]
var aniIdle = ["Idle_Up", "Idle_Left","Idle_Down","Idle_Right"]

onready var Grid = get_node("../../../../Grid")

#done in skills now, keeping for eneimes for now
func attack(target): 
	
	#if self.isPlayer: updateManaType(1) #just a test to see if mana updates. it does!!
	
	var damageCalc = damageCalc(target)[0]
	
	if damageCalc < 0: damageCalc = 0
	target.stats[target.HP] -= damageCalc
	
	var text = floatingText.instance()
	text.amount = damageCalc
	target.add_child(text)
	
	
	if target.HP <= 0: target.unitDeath()

#done in skills now
func damageCalc(target):
	var mult = 0
	var heightDiff = int((target.transform.origin[1] - target.spriteOffset) - (self.transform.origin[1] - self.spriteOffset))
	
	#use heightDiff to find a multiplier here
	if self.direction == target.direction:
		mult = 1.25
	elif ( self.direction + 2 ) % 4 == target.direction:
		mult = 0.85
	else:
		mult = 1
	
	return [max(0,int (mult * (self.stats[self.STR] - target.stats[target.DEF] ))), mult, heightDiff]

func unitDeath():
	self.stats[self.HP] = 0
	#$AnimatedSprite3D.animation = "Dead"
	#send signal here if anything else needs to do something on a unit death
	

func updateManaType(manaCost):
	if self.stats[self.MP] - manaCost >=0:
		self.stats[self.MP] -= manaCost
		self.manaType.updateMana(self, manaCost)
	else:
		print("not enoughMana")
