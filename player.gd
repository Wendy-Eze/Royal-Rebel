
extends CharacterBody2D

@onready var speed = 400
var walking = false
var is_attacking = false

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		$AnimatedSprite2D.play("attack")
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		is_attacking = false
		if not walking:
			$WalkTimer.start()
			walking = true

	else:
		if not is_attacking:
			$AnimatedSprite2D.play("idle")
		$WalkTimer.stop()
		walking = false
		
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0


func _physics_process(delta):
	get_input()
	move_and_slide()


func _on_walk_timer_timeout():
	$walk_sound.play()
