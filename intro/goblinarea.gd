extends Area2D
signal player_near

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("player is near goblin")
		player_near.emit()
		
