extends Control


var damagePath = "NinePatchRect/HBoxContainer/VBoxContainer/Damage Calc"
var accPath = "NinePatchRect/HBoxContainer/VBoxContainer/Acc Calc"
var attackSidePath = "NinePatchRect/HBoxContainer/VBoxContainer/Side Calc"
var heightPath = "NinePatchRect/HBoxContainer/VBoxContainer/Height Calc"
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false # Replace with function body.

func setDamageCalc(damage):
	get_node(damagePath).text = "Damage " + str(damage[0])
	get_node(accPath).text = "Acc 100%"
	get_node(attackSidePath).text = "Attack Side Mult " + str(damage[1])
	get_node(heightPath).text = "Height Mult " + str(damage[2])
