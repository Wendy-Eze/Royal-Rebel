extends Area2D


const LevelBegin = "res://level_"

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("begun game")
		get_tree().change_scene_to_file("res://level_1.tscn")

