
extends CharacterBody2D

@onready var speed = 500
var walking = false
var is_attacking = false
signal goblin_hit
@onready var end_of_bow = $Marker2D
@onready var arrow_cooldown = $Marker2D
var is_knight = false
var minpos = Vector2(0,15)
var maxpos = Vector2(12620, 4235)
signal death_over
var facing
@export var ghost_node : PackedScene
@onready var ghost_timer = $GhostTimer
var cool_started = false


func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	
	if Input.is_action_just_pressed("dash"):
			$AnimatedSprite2D.play("dash")
	
	if Globalvar.equip_arrow and Globalvar.ready_arrow:
		if Input.is_action_just_pressed("attack") and not cool_started:
			cool_started = true
			$Cooldown.start(0.7)
			is_attacking = true
			$AnimatedSprite2D.play("attack")
			arrow()
			$ArrowSound.play()
			Globalvar.arrow_num -= 1
			print(Globalvar.arrow_num)
			
	
	
	
	if Globalvar.equip_sword:
		if Input.is_action_just_pressed("attack") and not is_attacking and not cool_started:
			cool_started = true
			$Cooldown.start(1)
			print("melee")
			is_attacking = true
			$AnimatedSprite2D.play("basic_melee")
			$SwordSound.play()
			
			
	if Globalvar.has_armor:
		if Input.is_action_just_pressed("knight"):
			Globalvar.armor_equipped = not Globalvar.armor_equipped  # Toggle armor equipped status
			if Globalvar.armor_equipped:
			# Armor is now equipped
				$AnimatedSprite2D.hide()  # Hide the default character sprite
				$Knight.show()  # Show the knight armor sprite
			else:
			# Armor is now unequipped
				$AnimatedSprite2D.show()  # Show the default character sprite
				$Knight.hide()
			#if Globalvar.armor_equipped:
				#Globalvar.armor_equipped = true
				#$AnimatedSprite2D.hide()
				#$Knight.show()
			
#armor equipped
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		$Knight.play()
		is_attacking = false
		if not walking:
			$WalkTimer.start()
			walking = true

	else:
		if not is_attacking and not Globalvar.equip_sword and not Globalvar.equip_arrow:
			$AnimatedSprite2D.play("idle")
			$Knight.play("idle")
		if not is_attacking and Globalvar.equip_sword:
			$AnimatedSprite2D.play("idle with sword")
		if not is_attacking and Globalvar.equip_arrow:
			$AnimatedSprite2D.play("idle with bow")
		$WalkTimer.stop()
		walking = false
		
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
		$Knight.animation = "walk"
		$Knight.flip_v = false
		$Knight.flip_h = velocity.x < 0

		
func dash():
	ghost_timer.start()
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + velocity * 1.0, 0.30)
	await tween.finished
	ghost_timer.stop()
		##dashing = false
		##canDash = true
		
func _input(event):
	if event.is_action_pressed("dash"):
		dash()


func _physics_process(delta):
	get_input()
	#move_and_collide(delta * velocity)
	#move_and_slide()
	var collision = move_and_collide(delta * velocity)
	if collision:
		print(collision.get_collider().name.contains("ummy"))
		print(collision.get_collider().name)
		if collision.get_collider().name.contains("ummy"):
			print("dummy")
			velocity = Vector2.ZERO
	move_and_slide()
		#print("I collided with", collision.get_collider().name)
	var pos = position
	pos.x = clamp(pos.x, minpos.x, maxpos.x)
	pos.y = clamp(pos.y, minpos.y, maxpos.y)
	position = pos
	if Livecounter.num == 0:
		$AnimatedSprite2D.animation = "death"
		#$Death.play()
		$DeathTimer.start()
		
func add_ghost():
	var ghost = ghost_node.instantiate()
	ghost.set_property(position, $Sprite2D.scale)
	get_tree().current_scene.add_child(ghost)
	ghost.flip_h = $AnimatedSprite2D.flip_h
	ghost.flip_v = $AnimatedSprite2D.flip_v


func arrow():
	#if arrow_cooldown.is_stopped():
		#pass
	var arrow = preload("res://general/arrow.tscn").instantiate()
	add_child(arrow)
	arrow.global_position = end_of_bow.global_position  # Set the bullet's position
	
	var target = get_global_mouse_position()
	var direction_to_mouse 
	#= arrow.global_position.direction_to(target).normalized()
#
	if $AnimatedSprite2D.flip_h:
		direction_to_mouse = Vector2.LEFT
		#Vector2.LEFT.rotated(rotation)
		# Shoot left if player is flipped
		print("facing left")
	else:
		direction_to_mouse = Vector2.RIGHT  # Shoot right if player is not flipped

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

func _on_sword_hit_body_entered(body):
	if body.is_in_group("enemy"):
		$AnimatedSprite2D/SwordHit/CollisionShape2D2.disable = false 
		body._hit_by_sword()
		print("touched enemy")
		goblin_hit.emit()

func _on_death_timer_timeout():
	death_over.emit()


func _on_ghost_timer_timeout():
	add_ghost()


func _on_cooldown_timeout():
	cool_started = false
