extends Node2D

var mob_scene = [
	preload("res://mob_mushroom.tscn"),
	preload("res://mob_bat.tscn"),
	preload("res://mob_dog.tscn")
] 
var mob = null
var spawn_num = Globalvar.limit
var distance = 100

func _ready():
	call_deferred("spawn")


func spawn():
	if mob == null:
		for i in range(spawn_num): 
			var random_mob = mob_scene[randi() % mob_scene.size()]
			var new_obj = random_mob.instantiate()
			
			var min_x = 3750
			var max_x = 5750
			var min_y = 0
			var max_y = 1500
			
			var random_x = randi_range(min_x, max_x)
			var random_y = randi_range(min_y, max_y)
			while not (random_x > (min_x - distance) and random_x < (max_x + distance) and random_y > (min_y - distance) and random_y < (max_y + distance)):
				random_x = randi_range(min_x, max_x)
				random_y = randi_range(min_y, max_y)
			#var random_x = randi_range(3000, 10500)
			#var random_y = randi_range(200, 4250)
			new_obj.position = Vector2(random_x, random_y)
			get_parent().add_child(new_obj)
			mob = new_obj
