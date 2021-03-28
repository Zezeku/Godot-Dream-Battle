extends Node

class_name Buff


var my_buffTimer
var my_source
var my_target
var my_skill

func initialize(source, target, skill, buffTimer):
	my_buffTimer = buffTimer
	my_source = source
	my_target= target
	my_skill = skill
	
	print(my_buffTimer)


func name():
	return "Buff on " + str(my_source)

func update():
	print("My Source = ", my_source)
	print("My Target = ", my_target)
	print("My BuffTimer = ", my_buffTimer)
	
	my_buffTimer -= 1
	if my_buffTimer <= 0:
		print("Time to Expire!")
		
