extends Resource

class_name BuffEffect

#still cant define targets

func pre_execute(source, target, skill):
	print("Buff Effect: ", source.stats_text[skill.buffStat[0]], " +", skill.buffAmount[0], "%")
	

func execute(source, target, skill):
	pre_execute(source, target, skill)
	target.skillEffects.append(load("res://Job System/Skill System/SkillEffects/Buff.gd").new())
	target.skillEffects[0].initialize(source, target, skill, skill.buffTimer[0])
	print(target.skillEffects[0].name())
	
	

func update(source, target, skill):
	pass
