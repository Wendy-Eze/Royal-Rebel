extends Node2D

var mob_scene = preload("res://mob_goblin.tscn")
var mob = null
var spawn_num = Globalvar.limit
#var first_spawned_enemy = null
#var last_spawned_enemy = null

func _ready():
	##spawn()
	call_deferred("spawn")

func spawn():
	if mob == null:
		for i in range(spawn_num): 
			var new_obj = mob_scene.instantiate()
			var random_x = randi_range(3000, 10500)
			var random_y = randi_range(200, 4250)
			new_obj.position = Vector2(random_x, random_y)
			get_parent().add_child(new_obj)

			mob = new_obj

