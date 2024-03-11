extends Area2D

var speed = 30
var direction := Vector2.ZERO
signal goblin_hit

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

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		print("touched enemy")
		goblin_hit.emit()
		body._hit_by_arrow()
		body.arrow_hit = true
		queue_free()
