extends Node2D

var mob_scene = preload("res://mob_goblin.tscn")
var mob = null
var spawn_num = 5

func _ready():
	##spawn()
	call_deferred("spawn")
	##pass
	
#func _process(_delta):
	#if mob == null:
		#var new_obj = mob_scene.instantiate()
		#new_obj.position = position
		#get_parent().add_child(new_obj)
		#mob = new_obj

func spawn():
	if mob == null:
		for i in range(spawn_num):
			var new_obj = mob_scene.instantiate()
			var random_x = randi_range(0, 3000)
			var random_y = randi_range(0, 2500)
			new_obj.position = Vector2(random_x, random_y)
			get_parent().add_child(new_obj)
