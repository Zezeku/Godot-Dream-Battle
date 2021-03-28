extends Position2D

onready var label = $FloatingDamage
onready var tween = $Tween
var amount = 0

func _ready():
	position = get_node("../../../../../CameraNode/Camera").unproject_position(get_parent().transform.origin)
	label.set_text(str(-1*amount))
	
	tween.interpolate_property(self, 'scale', scale, Vector2(2,2), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.interpolate_property(self, 'position', position, position + Vector2(10, 10), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	
	tween.interpolate_property(self, 'scale', Vector2(2,2), Vector2(1.5, 1.5), 0.4, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.3)
	tween.interpolate_property(self, 'position', position + Vector2(10, 10), position + Vector2(10, -10), 0.4, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.3)
	tween.start()
	

func _on_Tween_tween_all_completed():
	self.queue_free() 
