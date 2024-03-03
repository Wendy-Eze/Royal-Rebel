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
	print("tutorial begins")
	$HUD/PlayerHealth.show()
	$HUD.show_message("Get Ready")
	$TutorialSteps/WalkStep.show()
	$WalkStepTime.start()

func goblin_step():
	$TutorialSteps/GoblinStep.show()
	$GoblinStepTime.start()

func store_step():
	$TutorialSteps/StoreStep.show()
	$StoreStepTimer.start()

func begin_game():
	$TutorialSteps/Start_Game.show()
	
func _on_goblin_step_time_timeout():
	$TutorialSteps/GoblinStep.hide()
	$GoblinArea/CollisionShape2D.disabled = true
	#$BeginGame/CollisionShape2D.disabled = false

func _on_walk_step_time_timeout():
	$TutorialSteps/WalkStep.hide()

func _on_store_step_timer_timeout():
	$TutorialSteps/StoreStep.hide()
	$StoreArea/CollisionShape2D.disabled = true
