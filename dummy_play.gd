extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.scale *= 0.6
	Globalvar.has_arrow = true 
	Globalvar.has_sword = true 
	Globalvar.equip_arrow = false
	Globalvar.equip_sword = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
