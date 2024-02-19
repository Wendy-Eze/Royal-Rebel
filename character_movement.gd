
extends CharacterBody2D

@onready var speed = 400

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	
	if velocity.length() != 0:
		$walk_sound.play()
	else:
		$walk_sound.stop()
	

func _physics_process(delta):
	get_input()
	move_and_slide()
