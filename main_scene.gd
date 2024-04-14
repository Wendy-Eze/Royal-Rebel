extends Node


func _ready():
	$Player.scale *= .6
	Globalvar.in_tut = true

func _process(delta):
	pass
	
func new_game():
	$opening_cutscene.start()
	$HUD/Message.hide()
	$HUD/PlayerHealth.hide()
	$HUD/Inventory.hide()
	#$Player.start()
	#$HUD.show_message("Get Ready")
	#$TutorialSteps/WalkStep.show()
	#$WalkStepTime.start()
	#$BeginGame/CollisionShape2D.disabled = true

func game_begins():
	$opening_cutscene.queue_free()
	Globalvar.opening_done = true
	#$Stepbystep.show()
	#$Player.start()
	#$Trees.show()
	#$HUD/Inventory.show()
	#$Player/TutCam.enabled = true
	#print("tutorial begins")
	#$HUD/PlayerHealth.show()
	#$HUD.show_message("Get Ready")

func game():
	$Stepbystep.queue_free()
	$Player.start()
	$Trees.show()
	#$HUD/Inventory.show()
	$Player/TutCam.enabled = true
	print("tutorial begins")
	$GameHUD.show()
	#$HUD/PlayerHealth.show()
	$HUD.show_message("Get Ready")
	$Market.show()

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

