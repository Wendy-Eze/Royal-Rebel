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
var key_instance = 0
var is_hit = false
var cool_started = false
@onready var player = get_parent().get_node("Player")



func _ready():
	pass

func set_health_bar():
	$HealthBar.value = health

func _physics_process(delta):
	
	if Globalvar.equip_arrow:
		damage = 8
		$HealthBar.step = 8
	if Globalvar.equip_arrow and Globalvar.level == 2:
		damage = 5
		$HealthBar.step = 5
	if Globalvar.equip_arrow and Globalvar.level == 3:
		damage = 3
		$HealthBar.step = 3
		
	if Globalvar.level == 2:
		damage = 10
		$HealthBar.step = 10
	if Globalvar.level == 3:
		damage = 3
		$HealthBar.step = 3
	if Globalvar.level == 3 and Globalvar.has_diamondsword:
		damage = 7
		$HealthBar.step = 7
		
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
		if Input.is_action_just_pressed("basic_melee") and not cool_started:
			#$AnimatedSprite2D.play("take_hit")
			cool_started = true
			$Cooldown.start(1)
			health -= damage
			is_hit = true
			$AnimatedSprite2D.stop()
			$AnimatedSprite2D.play("take_hit")
			set_health_bar()
			$HealthBar.show()
			$HealthTimer.start()
			print("Goblin was hit! Health:", health)
		if position.distance_to(player_position) <= 250 and position.distance_to(player_position) >= 100 and not is_hit:
			#pass
			$AnimatedSprite2D.play("attack")
	
	if health <= 0:
		$AnimatedSprite2D.play("deaddrop")
		set_linear_velocity(Vector2.ZERO)
		#$DeathTimer.start()
		if not rtimer_started:
			$RespawnTimer.start()
			$Deathsound.play()
			#await $Deathsound.finished
			rtimer_started = true

#func _on_visible_on_screen_notifier_2d_screen_exited():
	#queue_free()
	#
#func _on_timer_timeout():
	#$AnimatedSprite2D.play("attack")
	##if not $AnimatedSprite2D.is_playing():
	##Livecounter.num -= 10
	#if position.distance_to(player_position) <= 250:
		#$DamageTimer.start(1)
		#print("timer started")
	#$Timer.stop()
	#
#func _on_damage_timer_timeout():
	#if Globalvar.level == 1:
		#Livecounter.num -= 5 
	#if Globalvar.level == 2:
		#Livecounter.num -= 8 
	#if Globalvar.level == 3:
		#Livecounter.num -= 10 
	
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
	$AnimatedSprite2D.play("take_hit")
	set_health_bar()
	$HealthTimer.start()
	$HealthBar.show()
	print("goblin was hit! ", health)

func _on_respawn_timer_timeout():
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
		Livecounter.num -= 10
	if $AnimatedSprite2D.animation == ("take_hit"):
		is_hit = false
		print("hit recognized")

func _on_cooldown_timeout():
	cool_started = false
