extends PopupMenu


func initSkillList(unit):
	
	clear()
	var skillList = unit.jobData.skillList
	var num_skills = skillList.size()-1
	
	for skillIndex in num_skills:
		add_item(skillList[skillIndex+1].skill_name)
		set_item_tooltip(skillIndex+1,skillList[skillIndex+1].tool_tip )
	

