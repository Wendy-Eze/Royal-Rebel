extends RigidBody2D

@export var speed = 100
var player_position
var target_position
var timer_started = false
var health: int = 100
var damage: int = 20
var rtimer_started = false

@onready var player = get_parent().get_node("Player")


func _ready():
	pass

func set_health_bar():
	$HealthBar.value = health

func _physics_process(delta):
	player_position = player.position
	target_position = (player.position - position).normalized()

	if position.distance_to(player_position) > 160 and position.distance_to(player_position) <= 800:
		set_linear_velocity(target_position * speed)
		if target_position.x > 0:
			$AnimatedSprite2D.play("run")
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.play("run")
			$AnimatedSprite2D.flip_h = true
		timer_started = false
	elif position.distance_to(player_position) > 800:
		set_linear_velocity(Vector2.ZERO)
		$AnimatedSprite2D.play("idle")
		timer_started = false
	else:
		set_linear_velocity(Vector2.ZERO)
		if not timer_started:
			$Timer.start()
			timer_started = true
			$AnimatedSprite2D.play("idle")
		if Input.is_action_just_pressed("basic_melee"):
			health -= damage
			set_health_bar()
			$HealthBar.show()
			$HealthTimer.start()
			print("Goblin was hit! Health:", health)
	
	if health <= 0:
		$AnimatedSprite2D.play("deaddrop")
		#$DeathTimer.start()
		if not rtimer_started:
			$RespawnTimer.start()
			rtimer_started = true


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
func _on_timer_timeout():
	$AnimatedSprite2D.play("attack")
	if position.distance_to(player_position) <= 160:
		#Livecounter.lives -= 1
		Livecounter.num -= 20
	$Timer.stop()

func _hit_by_arrow():
	health -= damage
	set_health_bar()
	$HealthBar.show()
	$HealthTimer.start()
	print("goblin was hit! ", health)

func _hit_by_sword():
	health -= damage
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



func _on_health_timer_timeout():
	$HealthBar.hide()


#func _on_death_timer_timeout():
	#queue_free()
