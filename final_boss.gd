extends Node2D

var index = 0 

func _ready():
	$StaticBody2D2.collision_layer = 0
	$StaticBody2D2.collision_mask = 0
	$GameHUD/KillCount_G.hide()
	Globalvar.has_armor = true
	Globalvar.has_arrow = true 
	Globalvar.has_sword = true
	Globalvar.equip_arrow = false
	Globalvar.equip_sword = false
	get_tree().paused = false


func _process(delta):
	$Player/Camera2D.enabled = false
	$Player/TutCam.enabled = false
	$Player/Final.enabled = true
	Globalvar.level = 4
	#if index >= 1: 
		#$StaticBody2D2/entrance.enabled = true


func _on_trigger_body_entered(body):
	if body.is_in_group("player"):
		$StaticBody2D2.collision_layer = 1
		$StaticBody2D2.collision_mask = 1
		$Map/gate.show()

