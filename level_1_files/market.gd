extends Node2D



func _ready():
	pass
	
func _physics_process(_delta):
	if Globalvar.level == 3:
		$Building.hide()
		$Building.tile_set.set_physics_layer_collision_mask(0,0)
		$PotionScene/Collider/AnimatedSprite2D.hide()
	

