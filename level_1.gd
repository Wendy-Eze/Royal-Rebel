extends Node

#var level_done_sound
#var next_level_sound
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.scale *= 0.6
	Globalvar.level = 1
	Goblinkill.num = 0
	Coincounter.num = 0
	Globalvar.arrow_num = 30
	Globalvar.in_tut = false
	Globalvar.has_arrow = true 
	Globalvar.has_sword = true 
	Globalvar.equip_arrow = false
	Globalvar.equip_sword = false
	get_tree().paused = false
	#level_done_sound = $level_done_sound
	#next_level_sound = $next_level_sound # Replace AudioStreamPlayer2 with the appropriate node name
  # Assuming the AudioStreamPlayer is named accordingly
	#$mob_spawner.delete_first_and_last_spawned_enemies()
	#Globalvar.is_invisible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Player/Camera2D.enabled = true
	$Player/TutCam.enabled = false
	$Player/Final.enabled = false
	
	if Globalvar.lvl1_done:
		$NextLevMission/Knight.show()
		$level_done_sound.play()
	
	if Globalvar.armor_equipped:
		$GameHUD/WTimer.stop()
		$NextLevMission/Convo.hide()
		$GameHUD/Warning.hide()
		$GameHUD/Warning_Message.hide()
		$GameHUD/WarningTimer.hide()
		$NextLevMission/Pass/CollisionShape2D.disabled = true
	$GameHUD/WarningTimer.text = "%d" % [int($GameHUD/WTimer.time_left)]

#func _on_mission_timer_timeout():
	#$Level1.hide()
	##$GameHUD.show()

func _on_armor_check_body_entered(body):
	if body.is_in_group("player") and not Globalvar.armor_equipped and Globalvar.lvl1_done:
		$GameHUD/WTimer.start()
		$NextLevMission/Convo.show()
		$GameHUD/Warning.show()
		$GameHUD/Warning_Message.show()
		$GameHUD/WarningTimer.show()
		#$GameHUD/WarningTimer.text = str($GameHUD/WTimer.time_left)
	if body.is_in_group("player") and not Globalvar.lvl1_done:
		$GameHUD/Mission.show()

func _on_w_timer_timeout():
	#$GameHUD/PlayerHealth.value = 0
	$GameHUD/GameOverScreen.show()
	print("timer works")
	


func _on_player_death_over():
	$GameHUD/GameOverScreen.show()
	$GameHUD/PlayerHealth.hide()


func _on_armor_check_body_exited(body):
	if body.is_in_group("player") and not Globalvar.lvl1_done:
		$GameHUD/Mission.hide()
		
func play_next_level_sound():
	$next_level_sound.play()
