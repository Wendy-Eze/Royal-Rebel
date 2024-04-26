extends Control

var done = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not done:
		if Goblinkill.num < Globalvar.limit:
			$EndMission/CollisionShape2D.disabled = true
			$Armor/CollisionShape2D.disabled = true 
		else:
			$EndMission/CollisionShape2D.disabled = false
			Globalvar.lvl1_done = true
			$Message/Alldead.show()
			$MissionDetect/CollisionShape2D.disabled = true
	else:
		$EndMission/CollisionShape2D.disabled = true
		#pass
		#done = true

func _on_mission_detect_body_entered(body):
	if body.is_in_group("player"):
		$Intro.show()
		$Help.hide()
		$IntroTimer.start()
#
#func _on_intro_timer_timeout():
	#$Intro.hide()

func _on_end_mission_body_entered(body):
	if body.is_in_group("player"):
		$OutroTimer.start()
		$Message/Alldead.hide()
		$Outro.show()
		$Armor.show()
		$EndMission/CollisionShape2D.disabled = true
		done = true

func _on_outro_timer_timeout():
	$Outro.hide()
	$Armor/CollisionShape2D.disabled = false
	#$EndMission/CollisionShape2D.disabled = true
	#done = true
	$OutroTimer.queue_free()
	
func _on_armor_body_entered(body):
	if body.is_in_group("player"):
		Globalvar.has_armor = true
		$Message/Cross.show()
		$Message/Timer.start()
		print("Knight armor collected")
		$Armor.queue_free()
		$Armor/CollisionShape2D.disabled = true
		$EndMission/CollisionShape2D.disabled = true


func _on_mission_detect_body_exited(body):
	if body.is_in_group("player"):
		$Intro.hide()


func _on_timer_timeout():
	$Message/Cross.hide()
