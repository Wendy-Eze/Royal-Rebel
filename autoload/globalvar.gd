extends Node

#Stealth Purposes
var is_invisible = false

#Arrow Functionality
var ready_arrow = false
var arrow_num = 30 
var has_armor = false
var armor_equipped = false


#Inventory Purposes
var equip_arrow = false
var equip_sword = false
var equip_potion = false
var i_num = 0
var use_potion = false 

#Arrow level
var asilver = true
var agold = false
var adiamond = false

var first = 0

#LEVEL 2
var entered_kingdom = false
var missions = 0 
var playertimerout = false
var witch_shown = false
var witch_done = false


#levels
var level = 0 

# Called when the node enters the scene tree for the first time.
func _ready():
	#pass
	ready_arrow = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if arrow_num == 0:
		#ready_arrow = false
	pass
