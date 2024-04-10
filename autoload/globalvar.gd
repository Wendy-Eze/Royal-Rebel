extends Node

#Stealth Purposes
var is_invisible = false

#Arrow Functionality
var ready_arrow = false
var arrow_num = 30 
var has_armor = false
var armor_equipped = false

#Dungeon + Kingdom 
var in_dungeon = false
var mission_done = false
#var in_kingdom = false
var is_guard = false
var has_key = false
var has_armorkey = false
var blindknight = false
var unlocked_armory = false 
var gaurd_dead = false

#Inventory Purposes
var equip_arrow = false
var equip_sword = false
var equip_potion = false
var equip_gold = false
var equip_diamond = false
var i_num = 0
var use_potion = false 
var has_goldsword = false
var has_diamondsword = false

var has_arrow = false
var has_sword = false
var in_tut = false

#Arrow level
var asilver = true
var agold = false
var adiamond = false

var first = 0
var collected = false

#LEVEL1
var lvl1_done = false

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
