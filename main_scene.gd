extends Node


func _ready():
	pass
	
func _process(delta):
	pass
	
func new_game():
	$Player.start()
	$HUD.show_message("Get Ready")
	$TutorialSteps/WalkStep.show()
	$WalkStepTime.start()
	$BeginGame/CollisionShape2D.disabled = true

func goblin_step():
	$TutorialSteps/GoblinStep.show()
	$GoblinStepTime.start()

func store_step():
	$TutorialSteps/StoreStep.show()
	$StoreStepTimer.start()
	
func _on_goblin_step_time_timeout():
	$TutorialSteps/GoblinStep.hide()
	$BeginGame/CollisionShape2D.disabled = false

func _on_walk_step_time_timeout():
	$TutorialSteps/WalkStep.hide()

func _on_store_step_timer_timeout():
	$TutorialSteps/StoreStep.hide()
