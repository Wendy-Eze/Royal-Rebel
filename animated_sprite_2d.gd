extends CharacterBody2D


var speed
var facing_down = true
var player_position
var target_position
var health: int = 100
var damage: int = 10
@onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	player_position = player.position
	target_position = (player.position - position).normalized()


	if $RayCast2D.is_colliding():
		if position.distance_to(player_position) > 300 and position.distance_to(player_position) <= 1000:
			speed = 200
			position += target_position * speed * delta
		elif position.distance_to(player_position) > 1000:
			pass
		else:
			Livecounter.num -= 20
	if position.distance_to(player_position) <= 400:
		if Input.is_action_just_pressed("basic_melee"):    
			health -= damage
	
	if health <= 0:
		queue_free()
