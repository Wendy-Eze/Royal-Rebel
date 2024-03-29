extends Area2D


const LevelBegin = "res://level_"

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("next level")
		var current_level = get_tree().current_scene.scene_file_path
		var next_level_num = current_level.to_int() + 1
		var next_level_path = LevelBegin + str(next_level_num) + ".tscn"
		get_tree().change_scene_to_file(next_level_path)

func _process(delta):
	if Goblinkill.num < 10:
		$CollisionShape2D.disabled = true
	else:
		$CollisionShape2D.disabled = false 
