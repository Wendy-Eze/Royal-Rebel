extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_restart_button_pressed():
	Livecounter.num = 100
	if Globalvar.level == 1:
		get_tree().change_scene_to_file("res://level_1.tscn")
		Goblinkill.num = 0
		Globalvar.has_armor = false 
		Globalvar.armor_equipped = false
	if Globalvar.level == 2:
		get_tree().change_scene_to_file("res://level_2.tscn")
	if Globalvar.level == 3:
		get_tree().change_scene_to_file("res://level_3.tscn")
		Goblinkill.num = 0
	if Globalvar.level == 3:
		get_tree().change_scene_to_file("res://level_3.tscn")
		Goblinkill.num = 0


func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://main_scene.tscn")
