extends "res://Unit Scripts/Units.gd"

var isPlayer = true

#stats would be specific to character

func move(input):
	#it needs to account for camera angle
	var loc = []
	var translate = [Vector3(-1,0,0), Vector3(0,0,1), Vector3(1,0,0), Vector3(0,0,-1)]
	var index = (get_node("../../../../CameraNode").cam_dir + input) % translate.size()
	
	loc = transform.origin + translate[index]
	
	if isValidMove(loc):
		loc[1] = Grid.grid[loc[0]-0.5][-1*loc[2]-0.5][2] + self.spriteOffset
		transform.origin = loc
		self.direction = input
		self.sprite.animation = aniMove[self.direction]
		
	else: pass


func attackAnimation(curLoc): 
	
	var camDirection  = get_node("../../../../CameraNode").cam_dir
	var displacement = curLoc - self.transform.origin
	
	
	#need to condense this. save booleans as arrays, then use camDirection to get index ie required booleans)
	if camDirection == 3:
		if displacement[2] <= 0 and abs(float(displacement[2])) >= abs(float(displacement[0])):
			self.direction = UP
		elif displacement[2] > 0 and abs(float(displacement[2])) >= abs(float(displacement[0])):
			self.direction = DOWN
		elif displacement[0] < 0 :
			self.direction = LEFT
		else:
			self.direction = RIGHT
	elif camDirection == 0:
		if displacement[0] <= 0 and abs(float(displacement[0])) >= abs(float(displacement[2])):
			self.direction = UP
		elif displacement[0] > 0 and abs(float(displacement[0])) >= abs(float(displacement[2])):
			self.direction = DOWN
		elif displacement[2] > 0 :
			self.direction = LEFT
		else:
			self.direction = RIGHT
	elif camDirection == 1:
		if displacement[2] >= 0 and abs(float(displacement[2])) >= abs(float(displacement[0])):
			self.direction = UP
		elif displacement[2] < 0 and abs(float(displacement[2])) >= abs(float(displacement[0])):
			self.direction = DOWN
		elif displacement[0] > 0 :
			self.direction = LEFT
		else:
			self.direction = RIGHT
	else:
		if displacement[0] >= 0 and abs(float(displacement[0])) >= abs(float(displacement[2])):
			self.direction = UP
		elif displacement[0] < 0 and abs(float(displacement[0])) >= abs(float(displacement[2])):
			self.direction = DOWN
		elif displacement[2] < 0 :
			self.direction = LEFT
		else:
			self.direction = RIGHT
		
	
	self.sprite.animation = aniIdle[self.direction]
	#self.direction = input
	#$AnimatedSprite3D.animation = aniIdle[self.direction]
	pass

func resetMove(activeUnitStart):
	transform.origin = activeUnitStart
	resetAnimation()
	
func setAnimation():
	self.sprite.animation = aniIdle[self.direction]

func waitAnimation(input):
	self.direction = input
	self.sprite.animation = aniIdle[self.direction]



func resetAnimation():
	self.sprite.animation = aniIdle[self.get_parent().get_parent().get_parent().activeUnitDirection]
	

func endMove():
	if Grid.allowedTiles.find([transform.origin[0]-0.5, -1*transform.origin[2]-0.5]) != -1:
		if Grid.grid[transform.origin[0]-0.5][-1*transform.origin[2]-0.5][4] == 0 :
			if Grid.grid[transform.origin[0]-0.5][-1*transform.origin[2]-0.5][5] == 0 :
				return true
	return false

func selectAttack(curLoc):
	if Grid.allowedTiles.find([curLoc[0]-0.5, -1*curLoc[2]-0.5]) == -1:
		return false
	if Grid.grid[curLoc[0]-0.5][curLoc[2]*(-1)-0.5][4] == 1:
		return true
	if Grid.grid[curLoc[0]-0.5][curLoc[2]*(-1)-0.5][5] == 1:
		return true
	
	return false
	

func isValidMove(loc):  #doesnt allow scrolling outside map
	if loc[0] >= 0 and loc[0] <= 10 and loc[2] <= 0 and loc[2] >= -10:
		if Grid.grid[loc[0]-0.5][-1*loc[2]-0.5][3] != 0:
			return true
	return false
	
