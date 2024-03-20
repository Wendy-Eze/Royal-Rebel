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


func goblin_step():
	$TutorialSteps/GoblinStep.show()
	
	
func goblin_out():
	$TutorialSteps/GoblinStep.hide()

func store_step():
	$TutorialSteps/StoreStep.show()


func store_out():
	$TutorialSteps/StoreStep.hide()
	
func walk_tut():
	$TutorialSteps/WalkStep.show()

func walk_out():
	$TutorialSteps/WalkStep.hide()

func begin_game():
	$TutorialSteps/Start_Game.show()

