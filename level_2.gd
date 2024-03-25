extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.scale *= 0.6
	Globalvar.arrow_num = 30
	Globalvar.level = 2
	$GameHUD/KillCount_G.hide()
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Player/Camera2D.enabled = true
	$Player/TutCam.enabled = false
