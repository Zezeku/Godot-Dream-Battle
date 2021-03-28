extends Spatial

#make sure camera height is high enough that it doesnt collide/go through meshes
#otherwise it clips walls in view

onready var tween = $Tween

enum CAM_DIR {NORTH = 0, EAST = 1, SOUTH = 2, WEST = 3}

var cam_dir = CAM_DIR.WEST

func _ready():pass
	#print($Camera.translation)
	#print($Camera.rotation)

func reset_camera():
	pass

func rotate_right(): 
	tween.interpolate_property(self, "rotation", self.rotation, self.rotation + Vector3(0, PI/8,0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_completed")
	get_node("../UnitManager").rotate_right()
	
	tween.interpolate_property(self, "rotation", self.rotation, self.rotation + Vector3(0, 3*PI/8,0), 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	cam_dir = (cam_dir + 1) % CAM_DIR.size() #keeping track of camera direction for inputs

func rotate_left():
	tween.interpolate_property(self, "rotation", self.rotation, self.rotation + Vector3(0, -PI/8,0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_completed")
	get_node("../UnitManager").rotate_left() #how can i do this furing tween?
	
	tween.interpolate_property(self, "rotation", self.rotation, self.rotation + Vector3(0, -3*PI/8,0), 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	cam_dir = (cam_dir + 3) % CAM_DIR.size() #keeping track of camera direction for inputs

func CameraUp():
	var new_loc = $Camera.translation + Vector3(-1,0,-1)
	tween.interpolate_property($Camera, "translation", $Camera.translation, new_loc, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


