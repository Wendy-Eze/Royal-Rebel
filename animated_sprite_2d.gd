extends CharacterBody2D


var speed
var facing_down = true
var player_position
var target_position
var health: int = 100
var damage: int = 10
@onready var player = get_parent().get_node("Player")
var is_wandering = true
var wander_timer = 0
var wander_interval = 3.0

var speed2 = 150 
var current = enemy_state.RIGHT
enum enemy_state {RIGHT,LEFT,UP,DOWN}
var dir


func _ready():
	$AnimatedSprite2D.play("idle")
	random_gen()
	#$Timer.start()
	
func _physics_process(delta):

	match current:
		enemy_state.RIGHT:
			move_right()
		enemy_state.LEFT:
			move_left()
		enemy_state.UP:
			move_up()
		enemy_state.DOWN:
			move_down()
	
	move_and_slide()
	
	player_position = player.position
	target_position = (player.position - position).normalized()


	if $ShapeCast2D.is_colliding():
		if position.distance_to(player_position) > 200 and position.distance_to(player_position) <= 1000:
			speed = 200
			position += target_position * speed * delta
			$AnimatedSprite2D.play("walk")
		elif position.distance_to(player_position) > 1000:
			#$AnimatedSprite2D.play("idle")
			pass
		else:
			Livecounter.num -= 20
	if position.distance_to(player_position) <= 400:
		if Input.is_action_just_pressed("basic_melee"):    
			health -= damage
	
	if health <= 0:
		queue_free()
		
	if Globalvar.in_dungeon:
		$CollisionShape2D.disabled = true
		$ShapeCast2D.enabled = false 
		hide()
	if not Globalvar.in_dungeon:
		$CollisionShape2D.disabled = false
		$ShapeCast2D.enabled = true 
		show()

func random_gen():
	dir = randi() % 4 + 1
	random_dir()
	
func random_dir():
	match dir:
		0:
			current = enemy_state.RIGHT
		1: 
			current = enemy_state.LEFT
		2:
			current = enemy_state.UP
		3:
			current = enemy_state.DOWN

func move_right():
	velocity = Vector2.RIGHT * speed2 
	$AnimatedSprite2D.play("run")
	$AnimatedSprite2D.flip_h = false
	
func move_left():
	velocity = Vector2.LEFT * speed2 
	$AnimatedSprite2D.play("run")
	$AnimatedSprite2D.flip_h = true

func move_down():
	velocity = Vector2.DOWN * speed2 
	$AnimatedSprite2D.play("run")

func move_up():
	velocity = Vector2.UP * speed2 
	$AnimatedSprite2D.play("run")


func _on_timer_timeout():
	random_gen()
	$Timer.start()
