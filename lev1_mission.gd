extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Goblinkill.num < 10:
		$EndMission/CollisionShape2D.disabled = true 
	else:
		$EndMission/CollisionShape2D.disabled = false

func _on_mission_detect_body_entered(body):
	if body.is_in_group("player"):
		$Intro.show()
		$IntroTimer.start()

func _on_intro_timer_timeout():
	$Intro.hide()
	$MissionDetect/CollisionShape2D.disabled = true

func _on_end_mission_body_entered(body):
	if body.is_in_group("player"):
		$Outro.show()

func _on_outro_timer_timeout():
	$Outro.hide()
