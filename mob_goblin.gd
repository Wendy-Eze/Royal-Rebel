extends RigidBody2D

@export var speed = 100
var player_position
var target_position
@onready var player = get_parent().get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("idle")
	#$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	player_position = player.position
	target_position = (player.position - position).normalized()
	
	if position.distance_to(player_position) > 200:
		set_linear_velocity(target_position * speed)
	else:
		set_linear_velocity(Vector2.ZERO)
		$AnimatedSprite2D.play("attack")
		
	if target_position.x > 0:
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = true

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
