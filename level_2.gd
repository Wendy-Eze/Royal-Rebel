extends Node

var attempt = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.scale *= 0.6
	Globalvar.arrow_num = 30
	Globalvar.level = 2
	$GameHUD/KillCount_G.hide()
	Globalvar.is_guard = true
	Globalvar.blindknight = true 
	$KnightKey.hide()
	Globalvar.has_diamondsword = false
	Globalvar.gaurd_dead = false
	Globalvar.has_armor = true
	Globalvar.has_arrow = true 
	Globalvar.has_sword = true
	Globalvar.equip_arrow = false
	Globalvar.equip_sword = false
	get_tree().paused = false
	Globalvar.in_dungeon = false
	Globalvar.armor_equipped = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Player/Camera2D.enabled = true
	$Player/TutCam.enabled = false
	$Player/Final.enabled = false
	
	if Globalvar.mission_done and not Globalvar.in_dungeon and attempt == 0:
		$Dialogue/Mission.show()
		$Dialogue/Timer.start()
		attempt = 1
	
	if Globalvar.mission_done:
			$MainMap/Kingdom/CastleEntrance/CollisionShape2D.disabled = true
			$level_done_sound.play()
	
	if Globalvar.has_key:
		$Dialogue/CollectedKey.show()
		
	if not Globalvar.has_key:
		$Dialogue/CollectedKey.hide()
		
	if Globalvar.mission_done:
		$Dialogue/Key.show()
		$Dialogue/CollectedKey.hide()
		$level_done_sound.play()
	
	if not Globalvar.mission_done:
		$Dialogue/Key.hide()
		
	if Globalvar.unlocked_armory:
		$Dialogue/Key.hide()

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
		$MainMap/Kingdom/CastleEntrance/CollisionShape2D.disabled = true
		$MainMap/Kingdom/CastleEntrance/Area2D/CollisionShape2D.disabled = true
		#$MainMap/PlayerScene/Area2D/CollisionShape2D.disabled = true 
		$MainMap/WitchScene/StaticBody2D.collision_layer = 0
		$MainMap/WitchScene/StaticBody2D.collision_mask = 0
		$MainMap/Fountain/StaticBody2D.collision_layer = 0
		$MainMap/Fountain/StaticBody2D.collision_mask = 0
		$MainMap/Kingdom/CastleEntrance.collision_layer = 0
		$MainMap/Kingdom/CastleEntrance.collision_mask = 0
		$MainMap/Kingdom/CastleEntrance/Area2D/CollisionShape2D.disabled = true
		$MainMap/MessengerScene/MessengerDialogue/Mission2.hide()
		$Statue.hide()
		if not Globalvar.gaurd_dead:
			$KnightKey.show()
		else:
			pass
		Globalvar.in_dungeon = true
		Globalvar.blindknight = false



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
		$MainMap/Kingdom/CastleEntrance/CollisionShape2D.disabled = false
		$MainMap/Kingdom/CastleEntrance/Area2D/CollisionShape2D.disabled = false
		$MainMap/WitchScene/StaticBody2D.collision_layer = 1
		$MainMap/WitchScene/StaticBody2D.collision_mask = 1
		$MainMap/Fountain/StaticBody2D.collision_layer = 1
		$MainMap/Fountain/StaticBody2D.collision_mask = 1
		$MainMap/Kingdom/CastleEntrance.collision_layer = 1
		$MainMap/Kingdom/CastleEntrance.collision_mask = 1
		$MainMap/Kingdom/CastleEntrance/Area2D/CollisionShape2D.disabled = false
		$Statue.show()
		#$KnightKey/CollisionShape2D.disabled = true
		Globalvar.blindknight = true
		
func _on_begin_body_entered(body):
	$Dialogue/Label.show()


func _on_begin_body_exited(body):
	$Dialogue/Label.hide()



func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		if not Globalvar.mission_done:
			$Dialogue/Confirm.show()
		if Globalvar.mission_done:
			$MainMap/Kingdom/CastleEntrance/CollisionShape2D.disabled = true


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		$Dialogue/Confirm.hide()


func _on_timer_timeout():
	$Dialogue/Mission.hide()
	
func play_next_level_sound():
	$next_level_sound.play()
