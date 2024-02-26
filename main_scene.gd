extends Node


func _ready():
	pass
	
func _process(delta):
	pass
	
func new_game():
	$Player.start()
	$HUD.show_message("Get Ready")
