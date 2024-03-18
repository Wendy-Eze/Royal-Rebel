extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Player/Camera2D.enabled = true
	$Player/TutCam.enabled = false
	
	if Globalvar.armor_equipped:
		$GameHUD/WTimer.stop()

func _on_mission_timer_timeout():
	$Panel.hide()
	$GameHUD.show()

func _on_armor_check_body_entered(body):
	if body.is_in_group("player") and not Globalvar.armor_equipped:
		$GameHUD/WTimer.start()
		$NextLevMission/Convo.show()
		$GameHUD/Warning.show()
		$GameHUD/Warning_Message.show()
		$GameHUD/WarningTimer.show()
		$GameHUD/WarningTimer.text = str($GameHUD/WTimer.time_left)

func _on_w_timer_timeout():
	$GameHUD/PlayerHealth.value == 0
