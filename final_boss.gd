extends Node


func _process(delta):
	$Player/Camera2D.enabled = true
	$Player/TutCam.enabled = false
