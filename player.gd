
extends CharacterBody2D

@onready var speed = 400
var walking = false
var is_attacking = false
@onready var end_of_bow = $Marker2D


func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		$AnimatedSprite2D.play("attack")
		arrow()
	
	if Input.is_action_just_pressed("basic_melee") and not is_attacking:
		print("melee")
		is_attacking = true
		$AnimatedSprite2D.play("basic_melee")	
	
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

func arrow():
	var arrow = preload("res://arrow.tscn").instantiate()
	add_child(arrow)
	arrow.global_position = end_of_bow.global_position  # Set the bullet's position
	
	var target = get_global_mouse_position()
	var direction_to_mouse = arrow.global_position.direction_to(target).normalized()
	
	arrow.set_direction(direction_to_mouse)

func _on_walk_timer_timeout():
	$walk_sound.play()

func start():
	show()
	$CollisionShape2D.disabled = false


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == ("basic_melee"):
		print("Stopping attack animation")
		is_attacking = false
		#$AnimatedSprite2D.stop()  # Stop the animation when it finishes
