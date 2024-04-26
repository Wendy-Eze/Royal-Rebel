extends CharacterBody2D

@export var speed = 600
var player_position
var target_position
var timer_started = false
var health: int = 100
var damage: int = 15
var is_hit = false
var rtimer_started = false
var coin_scene = preload("res://general/coin.tscn")
var arrow_scene = preload("res://general/arrow.tscn")
var key_scene = preload("res://key.tscn")
var arrow_hit = false
var key_instance = 0
@onready var player = get_parent().get_node("Player")



func _ready():
	pass

func set_health_bar():
	$HealthBar.value = health

func _physics_process(delta):
	var distance_to_player = 0
	
	if Globalvar.equip_arrow:
		damage = 10
	if Globalvar.equip_arrow and Globalvar.level == 2:
		damage = 8
	if Globalvar.equip_arrow and Globalvar.level == 3:
		damage = 6
		
	if Globalvar.level == 2:
		damage = 10
	if Globalvar.level == 3:
		damage = 5
	if Globalvar.level == 3 and Globalvar.has_diamondsword:
		damage = 10
		
	#if player:
		#player_position = player.position
		#target_position = (player.position - position).normalized()
	#else:
		#print("Player node not found or not initialized.")
	#if (position.distance_to(player_position) > 700 and position.distance_to(player_position) <= 800 and not Globalvar.is_invisible and not Globalvar.blindknight) or arrow_hit:
		#speed = 300
		#velocity = position.direction_to(player_position) * speed
		#move_and_collide(velocity*delta)
		##speed = min(speed * 1.5, 400)
		##move_and_collide(target_position * speed)
		#if target_position.x > 0:
			#$AnimatedSprite2D.play("walk")
			#$AnimatedSprite2D.flip_h = true
		#else:
			#$AnimatedSprite2D.play("walk")
			#$AnimatedSprite2D.flip_h = false
		#timer_started = false
	#elif position.distance_to(player_position) > 800:
		##stop moving and play idle
		#move_and_collide(Vector2.ZERO)
		#speed = 0
		#$AnimatedSprite2D.play("idle")
		#timer_started = false
	#else:
		#move_and_collide(Vector2.ZERO)
		#speed = 0
		##$AnimatedSprite2D.play("idle")
	if player:
		player_position = player.position
		target_position = (player.position - position).normalized()
		distance_to_player = position.distance_to(player_position)
	else:
		print("Player node not found or not initialized.")
		


	# Follow the player
	if distance_to_player > 500 and distance_to_player <= 1500:
		speed = 600
		velocity = target_position * speed
		move_and_collide(velocity * delta)
		# Play walk animation
		$AnimatedSprite2D.play("walk")
		if target_position.x > 0 and not is_hit:
			$AnimatedSprite2D.play("walk")
			#$Goblin.play()
			#await $Goblin.finished
			#to fliip demon
			$AnimatedSprite2D.flip_h = true
		#else:
		if target_position.x < 0 and not is_hit:
			$AnimatedSprite2D.play("walk")
			#$Goblin.play()
			$AnimatedSprite2D.flip_h = false
		
		
		##$AnimatedSprite2D.flip_h = target_position.x < 0
		#if target_position.x > 0:
			#$AnimatedSprite2D.play("walk")
			#$AnimatedSprite2D.flip_h = true
		#else:
			#$AnimatedSprite2D.play("walk")
			#$AnimatedSprite2D.flip_h = false
		#timer_started = false

	# Stop moving and play idle animation
	elif distance_to_player > 1200:
		move_and_collide(Vector2.ZERO)
		speed = 0
		$AnimatedSprite2D.play("idle")

	# Attack when close to the player and facing the player
	elif distance_to_player <= 500 and Vector2.UP.dot(target_position): #> 0.9:
		# Adjust attack range and direction based on the dot product of vectors
		$AnimatedSprite2D.play("attack")
		#pass

	# Otherwise, play idle animation
	else:
		move_and_collide(Vector2.ZERO)
		speed = 0
		$AnimatedSprite2D.play("idle")
		
		if not timer_started and not Globalvar.is_invisible and not Globalvar.blindknight:
			$Timer.start()
			timer_started = true
			$AnimatedSprite2D.play("idle")
		if Input.is_action_just_pressed("basic_melee"):
			$AnimatedSprite2D.play("damage")
			health -= damage
			set_health_bar()
			$HealthBar.show()
			$HealthTimer.start()
			print("demon was hit! Health:", health)
		if position.distance_to(player_position) <= 600:
			#and not is_hit
			pass
			#$AnimatedSprite2D.play("attack")
	
	if health <= 0:
		$AnimatedSprite2D.play("death")
		move_and_collide(Vector2.ZERO)
		#$DeathTimer.start()
		if not rtimer_started:
			$RespawnTimer.start() 
			$Deathsound.play()
			rtimer_started = true

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
func _on_timer_timeout():
	$AnimatedSprite2D.play("attack")
	#Livecounter.num -= 10
	if position.distance_to(player_position) <= 600:
		$DamageTimer.start()
		print("timer started")
	#$Timer.stop()
	
func _on_damage_timer_timeout():
	Livecounter.num -= 10
	
func _hit_by_arrow():
	health -= damage
	$Arrow.start(1)
	$AnimatedSprite2D.play("damage")
	set_health_bar()
	$HealthTimer.start()
	$HealthBar.show()
	print("demon was hit! ", health)
	#arrow_hit = true
	#set_linear_velocity((player_position - position).normalized() * speed)
#
func _hit_by_sword():
	health -= damage
	$AnimatedSprite2D.play("damage")
	set_health_bar()
	$HealthTimer.start()
	$HealthBar.show()
	print("demon was hit! ", health)

func _on_respawn_timer_timeout():
	#health = 100
		#set_linear_velocity(Vector2.ZERO)
		#position = Vector2(1769, 822)
		#target_position = (player.position - position).normalized()
		#$AnimatedSprite2D.play("idle")
		#rtimer_started = false
		#$RespawnTimer.stop()
	queue_free()
	
	Goblinkill.num += 1
	#add function like num += 1 goblinkill.num += 1
	drop_coin()

	
func drop_coin():
	var coin = coin_scene.instantiate()
	var arrow = arrow_scene.instantiate()
	coin.position = position
	arrow.position = position
	
	get_parent().add_child(coin)
	get_parent().add_child(arrow)
	#get_parent().add_child()
	
	if Globalvar.is_guard and key_instance == 0:
		var key = key_scene.instantiate()
		key.position = position
		get_parent().add_child(key)
		#Globalvar.has_key = true
		key_instance += 1


func _on_health_timer_timeout():
	$HealthBar.hide()


#func _on_death_timer_timeout():
	#queue_free()


#Knight
#


func _on_arrow_timeout():
	arrow_hit = false


func _on_sword_hit_body_entered(body):
	if body.is_in_group("player"):
		$AnimatedSprite2D.play("attack")


func _on_sword_hit_body_exited(body):
	if body.is_in_group("player"):
		$AnimatedSprite2D.stop()


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == ("attack"):
		print("attack finished")
		Livecounter.num -= 10
	if $AnimatedSprite2D.animation == ("take_hit"):
		is_hit = false
		print("hit recognized")
