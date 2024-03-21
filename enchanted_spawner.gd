extends Node2D

var mob_scene = [
	preload("res://mob_mushroom.tscn"),
	preload("res://mob_bat.tscn"),
	preload("res://mob_dog.tscn")
] 
var mob = null
var spawn_num = 12

func _ready():
	##spawn()
	call_deferred("spawn")
	#pass
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
			var random_mob = mob_scene[randi() % mob_scene.size()]
			var new_obj = random_mob.instantiate()
			var random_x = randi_range(3000, 10500)
			var random_y = randi_range(200, 4250)
			new_obj.position = Vector2(random_x, random_y)
			get_parent().add_child(new_obj)
			mob = new_obj