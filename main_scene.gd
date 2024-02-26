extends Node


func _ready():
	pass
	
func _process(delta):
	pass
	
func new_game():
	$Player.start()
	$HUD.show_message("Get Ready")
	

#func hit_by_arrow():
	#$Goblin.health -= 20 
	#print("goblin was hit!", $Goblin.health)
