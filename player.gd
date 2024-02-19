
extends CharacterBody2D

@onready var speed = 400
var walking = false

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		if not walking:
			$WalkTimer.start()
			walking = true

	else:
		$AnimatedSprite2D.stop()
		$WalkTimer.stop()
		walking = false
		
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false


func _physics_process(delta):
	get_input()
	move_and_slide()


func _on_walk_timer_timeout():
	$walk_sound.play()
