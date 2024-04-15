extends CharacterBody2D
@export var speed = 200
var init_speed = speed 
var player_position
var target_position
var timer_started = false
var health: int = 100
var damage: int = 10
var rtimer_started = false
var coin_scene = preload("res://general/coin.tscn")
var arrow_scene = preload("res://general/arrow.tscn")
var key_scene = preload("res://key.tscn")
var arrow_hit = false
var is_hit = false
var key_instance = 0
var cool_started = false
@onready var player1 = get_parent().get_node("Player")

#var run_speed = 100
var player = null
var is_running = false
var in_area = false


func get_input():
	pass
func _input(event):
	pass

func _on_cooldown_timeout():
	cool_started = false
	
func _physics_process(delta):
	get_input()
	#velocity = Vector2.ZERO
	#$AnimatedSprite2D.play("idle")
	#if player:
		#velocity = position.direction_to(player.position) * run_speed
		
	#move_and_slide()
	
	player_position = player1.position
	target_position = (player1.position - position).normalized()
	if (position.distance_to(player_position) > 280 and position.distance_to(player_position) <= 800 and not Globalvar.is_invisible and not Globalvar.blindknight) or arrow_hit:
		velocity = position.direction_to(player_position) * speed
		move_and_collide(velocity*delta)
		if target_position.x > 0 and not is_hit:
			$AnimatedSprite2D.play("run")
			$AnimatedSprite2D.flip_h = false
		#else:
		if target_position.x < 0 and not is_hit:
			$AnimatedSprite2D.play("run")
			$AnimatedSprite2D.flip_h = true
		timer_started = false
	elif position.distance_to(player_position) > 800:
		move_and_collide(Vector2.ZERO)
		$AnimatedSprite2D.play("idle")
		timer_started = false
	else:
		move_and_collide(Vector2.ZERO)
		if not timer_started and not Globalvar.is_invisible and not Globalvar.blindknight:
			$Timer.start(1)
			timer_started = true
			$AnimatedSprite2D.play("idle")
		if position.distance_to(player_position) <= 280 and not is_hit:
			#pass
			$AnimatedSprite2D.play("attack")
		if Input.is_action_just_pressed("basic_melee") and not cool_started:
			#$AnimatedSprite2D.play("take_hit")
			#is_hit = true
			cool_started = true
			$Cooldown.start(1)
			$AnimatedSprite2D.stop()
			$AnimatedSprite2D.play("take_hit")
			health -= damage
			set_health_bar()
			$HealthBar.show()
			$HealthTimer.start()
			print("Goblin was hit! Health:", health)
			
	if health <= 0:
		$AnimatedSprite2D.play("deaddrop")
		speed = 0 
		#$DeathTimer.start()
		if not rtimer_started:
			$RespawnTimer.start()
			$Deathsound.play()
			rtimer_started = true

#func _on_DetectRadius_body_entered(body):
	#if body.is_in_group("player"):
		#player = body
		#run_speed = 50
		#$AnimatedSprite2D.stop()
		#$AnimatedSprite2D.play("run")
	#if body.is_in_group("arrow"):
		#player = body
		#run_speed = 50
#
#func _on_DetectRadius_body_exited(body):
	#if body.is_in_group("player"):
		#player = null
		#$AnimatedSprite2D.stop()
		#$AnimatedSprite2D.play("idle")
#
#func _on_attack_body_entered(body):
	#if body.is_in_group("player"):
		#player = body
		#in_area = true
		#run_speed = 0 
		#$AnimatedSprite2D.play("attack")
		#
#func _on_attack_body_exited(body):
	#if body.is_in_group("player"):
		#player = null
		##run_speed = 50 
		#$AnimatedSprite2D.stop()
		
func _on_respawn_timer_timeout():
	queue_free()
	Globalvar.gaurd_dead = true
	Goblinkill.num += 1
	drop_coin()
	
func drop_coin():
	var coin = coin_scene.instantiate()
	var arrow = arrow_scene.instantiate()
	coin.position = position
	arrow.position = position
	
	get_parent().add_child(coin)
	get_parent().add_child(arrow)
	
	if Globalvar.is_guard and key_instance == 0:
		var key = key_scene.instantiate()
		key.position = position
		get_parent().add_child(key)
		#Globalvar.has_key = true
		key_instance += 1

func _on_health_timer_timeout():
	$HealthBar.hide()

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == ("attack"):
		print("attack finished")
		Livecounter.num -= 10
	if $AnimatedSprite2D.animation == ("take_hit"):
		is_hit = false
		print("hit recognized")
	#if $AnimatedSprite2D.animation == ("attack"):
		#print("attack finished")
		#Livecounter.num -= 10
		#$AnimatedSprite2D.play("attack")
	#if $AnimatedSprite2D.animation == ("take_hit"):
		#is_hit = true
		#print("hit recognized")
		#if is_hit:
			#$AnimatedSprite2D.play("attack")
		#else:
			#$AnimatedSprite2D.play("idle")
		
func set_health_bar():
	$HealthBar.value = health

func _hit_by_arrow():
	arrow_hit = true
	health -= damage
	is_hit = true
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.play("take_hit")
	set_health_bar()
	$HealthTimer.start()
	$HealthBar.show()
	print("goblin was hit! ", health)

#extends RigidBody2D
#
#@export var speed = 400
#var init_speed = speed 
#var player_position
#var target_position
#var timer_started = false
#var health: int = 100
#var damage: int = 10
#var rtimer_started = false
#var coin_scene = preload("res://general/coin.tscn")
#var arrow_scene = preload("res://general/arrow.tscn")
#var key_scene = preload("res://key.tscn")
#var arrow_hit = false
#var is_hit = false
#var key_instance = 0
#var cool_started = false
#@onready var player = get_parent().get_node("Player")
#
#
#
#func _ready():
	#pass
#
#func set_health_bar():
	#$HealthBar.value = health
#
#func _process(delta):
	#pass
#
#func _physics_process(delta):
	#
	#if Globalvar.equip_arrow:
		#damage = 8
	#if Globalvar.equip_arrow and Globalvar.level == 2:
		#damage = 5
	#if Globalvar.equip_arrow and Globalvar.level == 3:
		#damage = 3
		#
	#if Globalvar.level == 2:
		#damage = 10
	#if Globalvar.level == 3:
		#damage = 3
	#if Globalvar.level == 3 and Globalvar.has_diamondsword:
		#damage = 7
	#
	#
	#var bodies = get_colliding_bodies()
	#for body in bodies:
		#if body.name == "Player":
			#print(body.name)
			#speed = 0 
			#
	#player_position = player.position
	#target_position = (player.position - position).normalized()
	#if (position.distance_to(player_position) > 0 and position.distance_to(player_position) <= 800 and not Globalvar.is_invisible and not Globalvar.blindknight) or arrow_hit:
		#speed = min(speed * 1.5, 400)
		#speed = clamp(speed,init_speed * 1.5, 400)
		#set_linear_velocity(target_position * speed)
		#if target_position.x > 0 and not is_hit:
			#$AnimatedSprite2D.play("run")
			#$AnimatedSprite2D.flip_h = false
		##else:
		#if target_position.x < 0 and not is_hit:
			#$AnimatedSprite2D.play("run")
			#$AnimatedSprite2D.flip_h = true
		#timer_started = false
	#elif position.distance_to(player_position) > 800:
		#set_linear_velocity(Vector2.ZERO)
		#$AnimatedSprite2D.play("idle")
		#timer_started = false
	#else:
		#set_linear_velocity(Vector2.ZERO)
		#if not timer_started and not Globalvar.is_invisible and not Globalvar.blindknight:
			#$Timer.start(1)
			#timer_started = true
			#$AnimatedSprite2D.play("idle")
		#if Input.is_action_just_pressed("basic_melee"):
			##$AnimatedSprite2D.play("take_hit")
			#is_hit = true
			#$AnimatedSprite2D.stop()
			#$AnimatedSprite2D.play("take_hit")
			#health -= damage
			#set_health_bar()
			#$HealthBar.show()
			#$HealthTimer.start()
			#print("Goblin was hit! Health:", health)
#
		##if position.distance_to(player_position) <= 250 and not is_hit:
			###pass
			##$AnimatedSprite2D.play("attack")
	##for i in get_collision_layer_value():
		##var c = get_collision_layer_value(i)
		##if c.get_collider().collision_layer == 1:
			##$AnimatedSprite2D.play("attack")
				#
	#
	#if health <= 0:
		#$AnimatedSprite2D.play("deaddrop")
		#set_linear_velocity(Vector2.ZERO)
		##$DeathTimer.start()
		#if not rtimer_started:
			#$RespawnTimer.start()
			#$Deathsound.play()
			#rtimer_started = true
#
#func _hit_by_arrow():
	#health -= damage
	#is_hit = true
	#$AnimatedSprite2D.stop()
	#$AnimatedSprite2D.play("take_hit")
	#set_health_bar()
	#$HealthTimer.start()
	#$HealthBar.show()
	#print("goblin was hit! ", health)
	##arrow_hit = true
	##set_linear_velocity((player_position - position).normalized() * speed)
##
#func _hit_by_sword():
	#health -= damage
	#is_hit = true
	#$AnimatedSprite2D.stop()
	#$AnimatedSprite2D.play("take_hit")
	#set_health_bar()
	#$HealthTimer.start()
	#$HealthBar.show()
	#print("goblin was hit! ", health)
#
#func _on_respawn_timer_timeout():
	##health = 100
		##set_linear_velocity(Vector2.ZERO)
		##position = Vector2(1769, 822)
		##target_position = (player.position - position).normalized()
		##$AnimatedSprite2D.play("idle")
		##rtimer_started = false
		##$RespawnTimer.stop()
	#queue_free()
	#Globalvar.gaurd_dead = true
	#
	#Goblinkill.num += 1
	##add function like num += 1 goblinkill.num += 1
	#drop_coin()
#
	#
#func drop_coin():
	#var coin = coin_scene.instantiate()
	#var arrow = arrow_scene.instantiate()
	#coin.position = position
	#arrow.position = position
	#
	#get_parent().add_child(coin)
	#get_parent().add_child(arrow)
	##get_parent().add_child()
	#
	#if Globalvar.is_guard and key_instance == 0:
		#var key = key_scene.instantiate()
		#key.position = position
		#get_parent().add_child(key)
		##Globalvar.has_key = true
		#key_instance += 1
#
#func _on_health_timer_timeout():
	#$HealthBar.hide()
#
#func _on_animated_sprite_2d_animation_finished():
	#if $AnimatedSprite2D.animation == ("attack"):
		#print("attack finished")
		#Livecounter.num -= 10
	#if $AnimatedSprite2D.animation == ("take_hit"):
		#is_hit = false
		#print("hit recognized")
#
#
##func _on_body_entered(body):
	##if body.is_in_group("player"):
		##set_linear_velocity(Vector2.ZERO)
##
##
##func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	##if body.is_in_group("player"):
		##set_linear_velocity(Vector2.ZERO)
#
#
#
##extends CharacterBody2D
##
##@export var speed = 50
##var player_position
##var target_position
##var timer_started = false
##var health: int = 100
##var damage: int = 10
##var rtimer_started = false
##var coin_scene = preload("res://general/coin.tscn")
##var arrow_scene = preload("res://general/arrow.tscn")
##var key_scene = preload("res://key.tscn")
##var arrow_hit = false
##var is_hit = false
##var key_instance = 0
##var cool_started = false
##@onready var player = get_parent().get_node("Player")
##
##func _ready():
	##pass
##
##func set_health_bar():
	##$HealthBar.value = health
##
##func _process(delta):
	### Process character logic here
	##if Globalvar.equip_arrow:
		##damage = 8
	##if Globalvar.equip_arrow and Globalvar.level == 2:
		##damage = 5
	##if Globalvar.equip_arrow and Globalvar.level == 3:
		##damage = 3
##
	##if Globalvar.level == 2:
		##damage = 10
	##if Globalvar.level == 3:
		##damage = 3
	##if Globalvar.level == 3 and Globalvar.has_diamondsword:
		##damage = 7
	##
	##player_position = player.position
	##target_position = (player.position - position).normalized()
	##
	##if (position.distance_to(player_position) > 0 and position.distance_to(player_position) <= 800 and not Globalvar.is_invisible and not Globalvar.blindknight) or arrow_hit:
		##speed = min(speed * 1.5, 400)
		##move_and_collide(speed)
		##if target_position.x > 0 and not is_hit:
			##$AnimatedSprite2D.play("run")
			##$AnimatedSprite2D.flip_h = false
		##else:
			##if target_position.x < 0 and not is_hit:
				##$AnimatedSprite2D.play("run")
				##$AnimatedSprite2D.flip_h = true
		##timer_started = false
	##elif position.distance_to(player_position) > 800:
		##move_and_collide(Vector2.ZERO)
		##$AnimatedSprite2D.play("idle")
		##timer_started = false
	##else:
		##move_and_collide(Vector2.ZERO)
		##if not timer_started and not Globalvar.is_invisible and not Globalvar.blindknight:
			##$Timer.start(1)
			##timer_started = true
			##$AnimatedSprite2D.play("idle")
		##if Input.is_action_just_pressed("basic_melee"):
			##is_hit = true
			##$AnimatedSprite2D.stop()
			##$AnimatedSprite2D.play("take_hit")
			##health -= damage
			##set_health_bar()
			##$HealthBar.show()
			##print("Goblin was hit! Health:", health)
##
	##if health <= 0:
		##$AnimatedSprite2D.play("deaddrop")
		##move_and_collide(Vector2.ZERO)
		##if not rtimer_started:
			##$RespawnTimer.start()
			##$Deathsound.play()
			##rtimer_started = true
##
##func _hit_by_arrow():
	##health -= damage
	##is_hit = true
	##$AnimatedSprite2D.stop()
	##$AnimatedSprite2D.play("take_hit")
	##set_health_bar()
	##$HealthTimer.start()
	##$HealthBar.show()
	##print("goblin was hit! ", health)
##
##func _hit_by_sword():
	##health -= damage
	##is_hit = true
	##$AnimatedSprite2D.stop()
	##$AnimatedSprite2D.play("take_hit")
	##set_health_bar()
	##$HealthTimer.start()
	##$HealthBar.show()
	##print("goblin was hit! ", health)
##
##func _on_respawn_timer_timeout():
	##queue_free()
	##Globalvar.gaurd_dead = true
	##Goblinkill.num += 1
	##drop_coin()
##
##func drop_coin():
	##var coin = coin_scene.instance()
	##var arrow = arrow_scene.instance()
	##coin.position = position
	##arrow.position = position
##
	##get_parent().add_child(coin)
	##get_parent().add_child(arrow)
	##
	##if Globalvar.is_guard and key_instance == 0:
		##var key = key_scene.instance()
		##key.position = position
		##get_parent().add_child(key)
		##key_instance += 1
##
##func _on_health_timer_timeout():
	##$HealthBar.hide()
##
##func _on_animated_sprite_2d_animation_finished():
	##if $AnimatedSprite2D.animation == ("attack"):
		##print("attack finished")
		##Livecounter.num -= 10
	##if $AnimatedSprite2D.animation == ("take_hit"):
		##is_hit = false
		##print("hit recognized")

