extends Node2D

var mob_scene = preload("res://mob_goblin.tscn")
var mob = null

func _process(_delta):
	if mob == null:
		var new_obj = mob_scene.instantiate()
		new_obj.position = position
		get_parent().add_child(new_obj)
		mob = new_obj
