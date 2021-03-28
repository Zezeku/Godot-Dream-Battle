extends Resource

class_name JobStats


export(String) var job_name

export(int) var maxHP
export(int) var maxMP

export(int) var STR
export(int) var DEF
export(int) var SPD
export(int) var moveStat
export(int) var atkRangeStat

export(Resource) var spriteSheet

export(Resource) var manaType

export(Array, Resource) var skillList


func initialize(unit):
	unit.stats[unit.maxHP] = maxHP
	unit.stats[unit.HP] = maxHP
	unit.stats[unit.STR] = STR
	unit.stats[unit.DEF] = DEF
	unit.stats[unit.SPD] = SPD
	unit.stats[unit.moveStat] = moveStat
	unit.stats[unit.atkRangeStat] = atkRangeStat
	
	
	unit.sprite.frames = spriteSheet
	unit.sprite.animation = "Idle_Up"
	
	unit.stats[unit.maxMP] = maxMP
	unit.stats[unit.MP] = maxMP
	
	unit.base_stats = unit.stats
	
	
	manaType.initialize(unit)
	
	#if skillList: #test. this works
	#	print(skillList[0].skill_name)
	

#export skill list. use this list to grab from skill resource
