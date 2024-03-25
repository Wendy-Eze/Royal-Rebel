extends Node2D

var mob_scene = [
	preload("res://mob_mushroom.tscn"),
	preload("res://mob_bat.tscn"),
	preload("res://mob_dog.tscn")
] 
var mob = null
var spawn_num = 12
var distance = 100

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
			#var new_position = Vector2.ZERO
			#
			#var attempts = 10
			#while attempts > 0:
				#new_position = check_distance(new_obj)
				#if new_position != Vector2.ZERO:
					#break 
				#attempts -= 1
			#
			#if new_position == Vector2.ZERO:
				#break
			#
			#new_obj.position = new_position
			#get_parent().add_child(new_obj)
			
			var random_x = randi_range(3000, 10500)
			var random_y = randi_range(200, 4250)
			new_obj.position = Vector2(random_x, random_y)
			get_parent().add_child(new_obj)
			mob = new_obj

#func check_distance(new_obj):
	#var random_x = randi_range(3000, 10500)
	#var random_y = randi_range(200, 4250)
	#var new_position = Vector2(random_x, random_y)
	#
	#for child in get_parent().get_children():
		#if child != new_obj and child.position.distance_to(new_position) < distance:
			#return Vector2.ZERO
