extends Node


func _ready():
	pass
	
func _process(delta):
	pass
	
func new_game():
	$opening_cutscene.start()
	$HUD/Message.hide()
	$HUD/PlayerHealth.hide()
	#$Player.start()
	#$HUD.show_message("Get Ready")
	#$TutorialSteps/WalkStep.show()
	#$WalkStepTime.start()
	#$BeginGame/CollisionShape2D.disabled = true

func game_begins():
	$opening_cutscene.queue_free()
	$Player.start()
	$Trees.show()
	$Player/TutCam.enabled = true
	print("tutorial begins")
	$HUD/PlayerHealth.show()
	$HUD.show_message("Get Ready")
	#$TutorialSteps/WalkStep.show()
	#$WalkStepTime.start()

func goblin_step():
	$TutorialSteps/GoblinStep.show()
	$TutorialSteps/WalkStep.hide()
	$TutorialSteps/StoreStep.hide()
	$GoblinStepTime.start()

func store_step():
	$TutorialSteps/StoreStep.show()
	$TutorialSteps/WalkStep.hide()
	$TutorialSteps/GoblinStep.hide()
	$StoreStepTimer.start()

func walk_tut():
	$TutorialSteps/StoreStep.hide()
	$TutorialSteps/WalkStep.show()
	$TutorialSteps/GoblinStep.hide()
	$WalkStepTime.start()
	


func begin_game():
	$TutorialSteps/Start_Game.show()
	
func _on_goblin_step_time_timeout():
	$TutorialSteps/GoblinStep.hide()
	$GoblinArea/CollisionShape2D.disabled = true

func _on_walk_step_time_timeout():
	pass
	#$TutorialSteps/WalkStep.hide()

func _on_store_step_timer_timeout():
	$TutorialSteps/StoreStep.hide()
	$StoreArea/CollisionShape2D.disabled = true


func _on_walk_tut_player_near():
	pass # Replace with function body.


func _on_walk_tut_body_entered(body):
	pass # Replace with function body.
