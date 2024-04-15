extends RigidBody2D

var player_position
@onready var player = get_parent().get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_position = player.position
	
	if (position.distance_to(player_position) < 200):
		if Input.is_action_just_pressed("basic_melee"):
			$AnimationPlayer.play("hit")
