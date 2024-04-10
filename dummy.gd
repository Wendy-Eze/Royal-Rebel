extends RigidBody2D

@export var speed = 50
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
@onready var player = get_parent().get_node("Player")



func _ready():
	pass

func set_health_bar():
	$HealthBar.value = health

func _physics_process(delta):
	if Globalvar.equip_arrow:
		damage = 8
	if Globalvar.equip_arrow and Globalvar.level == 2:
		damage = 5
	if Globalvar.equip_arrow and Globalvar.level == 3:
		damage = 3
		
	if Globalvar.level == 2:
		damage = 10
	if Globalvar.level == 3:
		damage = 3
	if Globalvar.level == 3 and Globalvar.has_diamondsword:
		damage = 7
		
	player_position = player.position
	target_position = (player.position - position).normalized()
	if (position.distance_to(player_position) > 250 and position.distance_to(player_position) <= 800 and not Globalvar.is_invisible and not Globalvar.blindknight) or arrow_hit:
		speed = min(speed * 1.5, 400)
		set_linear_velocity(target_position * speed)
		if target_position.x > 0 and not is_hit:
			$AnimatedSprite2D.play("run")
			$AnimatedSprite2D.flip_h = false
		#else:
		if target_position.x < 0 and not is_hit:
			$AnimatedSprite2D.play("run")
			$AnimatedSprite2D.flip_h = true
		timer_started = false
	elif position.distance_to(player_position) > 800:
		set_linear_velocity(Vector2.ZERO)
		$AnimatedSprite2D.play("idle")
		timer_started = false
	else:
		set_linear_velocity(Vector2.ZERO)
		if not timer_started and not Globalvar.is_invisible and not Globalvar.blindknight:
			$Timer.start(1)
			timer_started = true
			$AnimatedSprite2D.play("idle")
		if Input.is_action_just_pressed("basic_melee"):
			#$AnimatedSprite2D.play("take_hit")
			is_hit = true
			$AnimatedSprite2D.stop()
			$AnimatedSprite2D.play("take_hit")
			health -= damage
			set_health_bar()
			$HealthBar.show()
			$HealthTimer.start()
			print("Goblin was hit! Health:", health)
		if position.distance_to(player_position) <= 250 and not is_hit:
			#pass
			$AnimatedSprite2D.play("attack")
	#for i in get_collision_layer_value():
		#var c = get_collision_layer_value(i)
		#if c.get_collider().collision_layer == 1:
			#$AnimatedSprite2D.play("attack")
				
	
	if health <= 0:
		$AnimatedSprite2D.play("deaddrop")
		set_linear_velocity(Vector2.ZERO)
		#$DeathTimer.start()
		if not rtimer_started:
			$RespawnTimer.start()
			$Deathsound.play()
			rtimer_started = true

func _hit_by_arrow():
	health -= damage
	is_hit = true
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.play("take_hit")
	set_health_bar()
	$HealthTimer.start()
	$HealthBar.show()
	print("goblin was hit! ", health)
	#arrow_hit = true
	#set_linear_velocity((player_position - position).normalized() * speed)
#
func _hit_by_sword():
	health -= damage
	is_hit = true
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.play("take_hit")
	set_health_bar()
	$HealthTimer.start()
	$HealthBar.show()
	print("goblin was hit! ", health)

func _on_respawn_timer_timeout():
	#health = 100
		#set_linear_velocity(Vector2.ZERO)
		#position = Vector2(1769, 822)
		#target_position = (player.position - position).normalized()
		#$AnimatedSprite2D.play("idle")
		#rtimer_started = false
		#$RespawnTimer.stop()
	queue_free()
	Globalvar.gaurd_dead = true
	
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

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == ("attack"):
		print("attack finished")
		#print("Current Livecounter.num:", Livecounter.num)
		Livecounter.num -= 10
		#print("After subtraction, Livecounter.num:", Livecounter.num)
		#$AnimatedSprite2D.play("attack")
	if $AnimatedSprite2D.animation == ("take_hit"):
		is_hit = false
		print("hit recognized")


#func _on_body_entered(body):
	#if body.is_in_group("player"):
		#set_linear_velocity(Vector2.ZERO)
#
#
#func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#if body.is_in_group("player"):
		#set_linear_velocity(Vector2.ZERO)
