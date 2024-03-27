extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.scale *= 0.6
	Globalvar.arrow_num = 30
	Globalvar.level = 2
	$GameHUD/KillCount_G.hide()
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Player/Camera2D.enabled = true
	$Player/TutCam.enabled = false


func _on_d_area_body_entered(body):
	if body.is_in_group("player"):
		$DungeonMap.show()
		$MainMap.hide()
		$Player.position = Vector2(6618,600)
		$MainMap/Kingdom.tile_set.set_physics_layer_collision_mask(0,0)
		$MainMap/Kingdom/Housing.tile_set.set_physics_layer_collision_mask(0,0)
		$MainMap/Kingdom/Pillars.tile_set.set_physics_layer_collision_mask(0,0)
		$MainMap/TileMap4.tile_set.set_physics_layer_collision_mask(0,0)
		$MainMap/Kingdom.tile_set.set_physics_layer_collision_layer(0,0)
		$MainMap/Kingdom/Housing.tile_set.set_physics_layer_collision_layer(0,0)
		$MainMap/Kingdom/Pillars.tile_set.set_physics_layer_collision_layer(0,0)
		$MainMap/TileMap4.tile_set.set_physics_layer_collision_layer(0,0)
		$MainMap/WitchScene/StaticBody2D/CollisionShape2D.disabled = true 
		$MainMap/WitchScene/Portal/CollisionShape2D.disabled = true 
		#$MainMap/PlayerScene/Area2D/CollisionShape2D.disabled = true 
		$MainMap/WitchScene/StaticBody2D.collision_layer = 0
		$MainMap/WitchScene/StaticBody2D.collision_mask = 0
		$MainMap/Fountain/StaticBody2D.collision_layer = 0
		
		Globalvar.in_dungeon = true


func _on_k_area_body_entered(body):
	if body.is_in_group("player"):
		$DungeonMap.hide()
		Globalvar.in_dungeon = false
		$MainMap.show()
		$Player.position = Vector2(7789,980)
		$MainMap/Kingdom.tile_set.set_physics_layer_collision_mask(0,1)
		$MainMap/Kingdom/Housing.tile_set.set_physics_layer_collision_mask(0,1)
		$MainMap/Kingdom/Pillars.tile_set.set_physics_layer_collision_mask(0,1)
		$MainMap/TileMap4.tile_set.set_physics_layer_collision_mask(0,1)
		$MainMap/Kingdom.tile_set.set_physics_layer_collision_layer(0,1)
		$MainMap/Kingdom/Housing.tile_set.set_physics_layer_collision_layer(0,1)
		$MainMap/Kingdom/Pillars.tile_set.set_physics_layer_collision_layer(0,1)
		$MainMap/TileMap4.tile_set.set_physics_layer_collision_layer(0,1)
		$MainMap/WitchScene/StaticBody2D/CollisionShape2D.disabled = false 
		$MainMap/WitchScene/Portal/CollisionShape2D.disabled = false 
		$MainMap/WitchScene/StaticBody2D.collision_layer = 1
		$MainMap/WitchScene/StaticBody2D.collision_mask = 1
		$MainMap/Fountain/StaticBody2D.collision_layer = 1
		
func _on_begin_body_entered(body):
	$Dialogue/Label.show()


func _on_begin_body_exited(body):
	$Dialogue/Label.hide()

