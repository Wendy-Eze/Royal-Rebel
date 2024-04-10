extends Node

func _ready():
	Globalvar.level = 0

func _process(delta):
	$Player/Camera2D.enabled = true
	$Player/TutCam.enabled = false

