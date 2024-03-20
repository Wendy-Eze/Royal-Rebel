extends Area2D

signal player_near
signal player_out

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("player is near store")
		player_near.emit()


func _on_body_exited(body):
	if body.is_in_group("player"):
		print("player is near store")
		player_out.emit()
