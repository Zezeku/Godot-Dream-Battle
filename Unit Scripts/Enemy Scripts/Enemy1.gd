extends "res://Unit Scripts/Enemy Scripts/Enemy.gd"

var spriteOffset = 0.8

enum {maxHP=0,HP=1,maxMP=2,MP=3,maxEXP=4,EXP=5,STR=6,DEF=7,SPD=8,moveStat=9,atkRangeStat=10}

var stats_text = ["maxHP","HP","maxMP","MP","maxEXP","EXP","STR","DEF","SPD","moveStat","atkRangeStat"]
var stats = [20,20,10,10,100,0,12,6,12,4,1]

var skillEffects = []

var isActive = false
var direction = DOWN
