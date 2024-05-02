extends CharacterBody2D
@export var speed = 400
var init_speed = speed 
var player_position
var target_position
var timer_started = false
var health: int = 100
var damage: int = 10
var pdam: int = 5
var rtimer_started = false
var coin_scene = preload("res://general/coin.tscn")
var arrow_scene = preload("res://general/arrow.tscn")
var key_scene = preload("res://key.tscn")
var arrow_hit = false
var is_hit = false
var key_instance = 0
var cool_started = false
@onready var player1 = get_parent().get_node("Player")
var enemyID: int = 0
#var run_speed = 100
#var player = null
#var is_running = false
var in_area = false

func _ready():
	add_to_group("enemy")
	#enemyID = get_instance_id()
	
func get_input():
	pass
func _input(event):
	pass

func _on_cooldown_timeout():
	cool_started = false
	
func _physics_process(delta):
	get_input()
	
	if Globalvar.equip_arrow:
		damage = 8 + Globalvar.adamage
		$HealthBar.step = 8
	if Globalvar.equip_arrow and Globalvar.level == 2:
		damage = 5 + Globalvar.adamage
		$HealthBar.step = 5
	if Globalvar.equip_arrow and Globalvar.level == 3:
		damage = 3 + Globalvar.adamage
		$HealthBar.step = 3
		
	if Globalvar.level == 2:
		damage = 10 + Globalvar.idamage
		$HealthBar.step = 10
		pdam = 8
	if Globalvar.level == 3:
		damage = 3 + Globalvar.idamage
		$HealthBar.step = 3
		pdam = 10
	if Globalvar.level == 3 and Globalvar.has_diamondsword:
		damage = 7 + Globalvar.ddamage
		$HealthBar.step = 7
	
	player_position = player1.position
	target_position = (player1.position - position).normalized()
	if (position.distance_to(player_position) > 350 and position.distance_to(player_position) <= 900 and not Globalvar.is_invisible and not Globalvar.blindking) or arrow_hit:
		velocity = position.direction_to(player_position) * speed
		move_and_collide(velocity*delta)
		if target_position.x > 0 and not is_hit:
			$AnimatedSprite2D.play("run")
			#$Goblin.play()
			#await $Goblin.finished
			$AnimatedSprite2D.flip_h = false
		#else:
		if target_position.x < 0 and not is_hit:
			$AnimatedSprite2D.play("run")
			#$Goblin.play()
			$AnimatedSprite2D.flip_h = true
		timer_started = false
	elif position.distance_to(player_position) > 900:
		move_and_collide(Vector2.ZERO)
		$AnimatedSprite2D.play("idle")
		timer_started = false
	else:
		move_and_collide(Vector2.ZERO)
		if not timer_started and not Globalvar.is_invisible and not Globalvar.blindking:
			$Timer.start(1)
			timer_started = true
			$AnimatedSprite2D.play("idle")
		if position.distance_to(player_position) <= 350 and not is_hit and not Globalvar.blindking:
			#pass
			$AnimatedSprite2D.play("attack")
			#$Goblin.play()
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
	#Globalvar.gaurd_dead = true
	#Goblinkill.num += 1
	##drop_coin()
	#if Globalvar.level == 4:
	Globalvar.king_dead = true
	
func drop_coin():
	var coin = coin_scene.instantiate()
	#var arrow = arrow_scene.instantiate()
	coin.position = position
	#arrow.position = position
	
	get_parent().add_child(coin)
	#get_parent().add_child(arrow)
	
	if Globalvar.is_guard and key_instance == 0 and Globalvar.level == 2:
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
		Livecounter.num -= pdam
	if $AnimatedSprite2D.animation == ("take_hit"):
		is_hit = false
		#$Hurt.stop()
		print("hit recognized")
		
func set_health_bar():
	$HealthBar.value = health

func _hit_by_arrow():
	arrow_hit = true
	health -= damage
	$Arrow.start(1)
	is_hit = true
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.play("take_hit")
	#$Hurt.play() 
	set_health_bar()
	$HealthTimer.start()
	$HealthBar.show()
	print("goblin was hit! ", health)

func _on_arrow_timeout():
	arrow_hit = false

