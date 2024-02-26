extends RigidBody2D

@export var speed = 100
var player_position
var target_position

var health: int = 100

@onready var player = get_parent().get_node("Player")
@onready var arrow = get_parent().get_node("Arrow")
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

func _on_body_entered(body):
	health -= 20
	print("goblin was hit!", health)
	
		
func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("player"):
		print("player in area")
		Livecounter.lives -= 1
	#if body.is_in_group("arrow"):
		#print("goblin hit by arrow")

func _hit_by_arrow():
	health -= 20
	print("goblin was hit! ", health)
	
func _hit_by_sword():
	health -= 20
	print("goblin was hit! ", health)
