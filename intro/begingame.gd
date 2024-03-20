extends Area2D

signal player_near
#const LevelBegin = "res://level_"

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("player wanting to start game")
		#get_tree().change_scene_to_file("res://level_1.tscn")
		player_near.emit()

