extends Node2D

var mob_scene = preload("res://mob_goblin.tscn")
var mob = null
var spawn_num = Globalvar.limit
#var first_spawned_enemy = null
#var last_spawned_enemy = null

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
			var new_obj = mob_scene.instantiate()
			var random_x = randi_range(3000, 10500)
			var random_y = randi_range(200, 4250)
			new_obj.position = Vector2(random_x, random_y)
			get_parent().add_child(new_obj)
			
			#if i == 0:
				#first_spawned_enemy = new_obj
			#elif i == spawn_num - 1:
				#last_spawned_enemy = new_obj
				#
			mob = new_obj

#func delete_first_and_last_spawned_enemies():
	#if first_spawned_enemy != null:
		#first_spawned_enemy.queue_free()
		#first_spawned_enemy = null
#
	#if last_spawned_enemy != null:
		#last_spawned_enemy.queue_free()
		#last_spawned_enemy = null
