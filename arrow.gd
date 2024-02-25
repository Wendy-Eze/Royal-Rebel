extends Area2D

var speed = 30
var direction := Vector2.ZERO

func _ready():
	pass 

func _process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed 
		global_position += velocity
		
		var angle = direction.angle()
		rotation = angle

func set_direction(direction:Vector2):
	self.direction = direction 
