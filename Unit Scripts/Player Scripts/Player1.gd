extends "res://Unit Scripts/Player Scripts/Player.gd"

#this is #pixels * pixel size in inspector
#for ghosts its 32bit * 0.02 = 0.64
#for enemies its 40bit * 0.02 = .8


var spriteOffset = 0.64

var maxHP
var HP

var maxMP
var MP

var maxEXP = 100
var EXP = 0

var STR
var DEF
var SPD
var moveStat
var atkRangeStat

var isActive = false
var direction = UP

var jobData
var manaType

func initializeStats(job):
	jobData = job
	jobData.initialize(self)
	
