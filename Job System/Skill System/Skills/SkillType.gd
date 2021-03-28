extends Resource

class_name SkillType

#enum {maxHP=0,HP=1,maxMP=2,MP=3,maxEXP=4,EXP=5,STR=6,DEF=7,SPD=8,moveStat=9,atkRangeStat=10}

export(String) var skill_name
export(String) var tool_tip

export(Resource) var manaType
export(int) var mana_cost

export(int) var damageRange
export(int) var damageAOERange
export(float) var multiplier

export(Array, int) var buffStat
export(Array, float) var buffAmount
export(Array, float) var buffTimer

export(Array, Resource) var skillEffect

#where do functions happen? same as attack but pulling from skill info instead of job stats
#how do i add effects?

#this needs to return GUIs for UI to display. similar to mana
#for now i force it to return damage effect info that UI calcWindow is looking for
#should this bring in sceondary and third targets sets?

func pre_execute(source, target):
	for s in skillEffect.size():
		skillEffect[s].pre_execute(source, target, self)

func execute(source, target):
	for s in skillEffect.size():
		skillEffect[s].execute(source, target, self)
	
	source.manaType.updateMana(source, mana_cost)
	

func passive_check(source, target):
	pass

func active_check(source, target):
	pass

func update(source, target):
	for s in skillEffect.size():
		skillEffect[s].update(source, target, self)



#ORDER OF OPERATIONS
#1) Check if enough mana to use, source MP - manaCost >= 0
#2) pre execute, get all info to send to GUI
#	2a) similar to Mana GUI, i can have skill build its own on the fly and send that back
#3) execute, perform all functions and commit changes
