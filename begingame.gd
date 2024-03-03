extends Area2D


#const LevelBegin = "res://level_"

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("game begun")
		#var current_level = get_tree().current_scene.scene_file_path
		#var next_level_num = current_level.to_int() + 1
		#var next_level_path = LevelBegin + str(next_level_num) + ".tscn"
		get_tree().change_scene_to_file("res://level_1.tscn")
