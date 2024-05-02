extends Area2D


func _on_body_entered(body):
	if body.is_in_group("player"):
		Globalvar.apple += 1 
#maybe have sound 
		queue_free()
