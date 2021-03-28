extends "res://Unit Scripts/Player Scripts/Player.gd"

#this is #pixels * pixel size in inspector
#for ghosts its 32bit * 0.02 = 0.64
#for enemies its 40bit * 0.02 = .8

var spriteOffset = 0.64
onready var sprite = get_node("PlayerXBody/PlayerXSprite")

enum {maxHP=0,HP=1,maxMP=2,MP=3,maxEXP=4,EXP=5,STR=6,DEF=7,SPD=8,moveStat=9,atkRangeStat=10}

var stats_text = ["maxHP","HP","maxMP","MP","maxEXP","EXP","STR","DEF","SPD","moveStat","atkRangeStat"]
var stats = [0,0,0,0,0,0,0,0,0,0,0]
var base_stats = [0,0,0,0,0,0,0,0,0,0,0]

var isActive = false
var direction = UP

var skillEffects = []

var jobData
var manaType
var manaGUI
var activeSkill

func initializeStats(job):
	jobData = job
	jobData.initialize(self)
	#initializing done in job once art asset done

