extends Node2D

var index = 0 
var attempt = 0
var talk_started = false
var bdialogue = [
	"YOU WILL NOT TAKE THIS ARTIFACT FROM ME!",
	"We will now fight to the death puny adventurer!",
]

func _ready():
	$StaticBody2D2.collision_layer = 0
	$StaticBody2D2.collision_mask = 0
	#$King.collision_mask = 0
	#$King.collision_layer = 0
	$GameHUD/KillCount_G.hide()
	Globalvar.level = 4
	Globalvar.has_armor = true
	Globalvar.has_arrow = true 
	Globalvar.has_sword = true
	Globalvar.equip_arrow = false
	Globalvar.equip_sword = false
	get_tree().paused = false
	#Globalvar.blindknight = true
	Globalvar.blindking = true


func _process(delta):
	$Player/Camera2D.enabled = false
	$Player/TutCam.enabled = false
	$Player/Final.enabled = true
	Globalvar.level = 4
	
	if Globalvar.knights_dead and not talk_started:
		#$King.show()
		$King.collision_mask = 1
		$King.collision_layer = 1
		$CanvasLayer/KingDialogue.show()
		$CanvasLayer/KingIcon.show()
		$CanvasLayer/Timer.start()
		talk_started = true
		
	#if Globalvar.knights_dead:
		#$Block.collision_layer = 0
		#$Block.collision_mask = 0
	
	if Globalvar.king_dead:
		$Suspense.stop()
		  
	#if index >= 1: 
		#$StaticBody2D2/entrance.enabled = true


func _on_trigger_body_entered(body):
	if body.is_in_group("player"):
		$StaticBody2D2.collision_layer = 1
		$StaticBody2D2.collision_mask = 1
		$Map/gate.show()
		if attempt == 0:
			$Message/Goal.show()
			attempt = 1
		$Suspense.play()
		$Message/GoalT.start(3)

func dialogue():
	if index < bdialogue.size():
		$CanvasLayer/KingDialogue.text = bdialogue[index]
		$CanvasLayer/Timer.start(5)
		index += 1
	else:
		$CanvasLayer/Timer.stop()
		$CanvasLayer/KingDialogue.hide() 
		$CanvasLayer/KingIcon.hide()
		Globalvar.blindking = false
		
func _on_timer_timeout():
	if index < bdialogue.size():
		$CanvasLayer/KingDialogue.text = bdialogue[index]
		$CanvasLayer/Timer.start(5)
		index += 1
	else:
		$CanvasLayer/Timer.stop()
		$CanvasLayer/KingDialogue.hide() 
		$CanvasLayer/KingIcon.hide()
		Globalvar.blindking = false


func _on_button_pressed():
	dialogue()
	#index += 1


func _on_suspense_finished():
	$Suspense.play()


func _on_goal_t_timeout():
	$Message/Goal.hide()
	Globalvar.blindknight = false
	Globalvar.knights_dead= true


func _on_king_area_body_entered(body):
	if body.is_in_group("player"):
		if Globalvar.king_dead:
			Globalvar.game_over = true
		#if not talk_started:
			#$CanvasLayer/KingDialogue.show()
			#$CanvasLayer/KingIcon.show()
			#$CanvasLayer/Timer.start()
			#talk_started = true  
