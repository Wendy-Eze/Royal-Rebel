extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	#$Player.scale *= 0.6
	pass


func _process(delta):
	
	if not Globalvar.in_dungeon:
		$TileMap.tile_set.set_physics_layer_collision_mask(0,0)
		$TileMap.tile_set.set_physics_layer_collision_layer(0,0)
	if Globalvar.in_dungeon:
		$TileMap.tile_set.set_physics_layer_collision_mask(0,1)
		$TileMap.tile_set.set_physics_layer_collision_layer(0,1)
