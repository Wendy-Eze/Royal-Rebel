extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_blacksmith_body_entered(body):
	pass
	#if body.is_in_group("player"):
		#$talk.show()

func _on_blacksmith_body_exited(body):
	pass
	#if body.is_in_group("player"):
		#$talk.hide()
