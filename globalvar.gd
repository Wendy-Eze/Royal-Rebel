extends Node

#Stealth Purposes
var is_invisible = false

#Arrow Functionality
var ready_arrow = false
var arrow_num = 80 
var has_armor = false

#Inventory Purposes
var equip_arrow = false
var equip_sword = false
var equip_potion = false
var i_num = 0
var use_potion = false 



# Called when the node enters the scene tree for the first time.
func _ready():
	ready_arrow = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if arrow_num == 0:
		#ready_arrow = false
	pass
