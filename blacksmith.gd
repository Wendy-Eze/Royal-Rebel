extends Area2D




#func _on_body_entered(body):
	#if body.is_in_group("player"):
		#$WeaponScene/talk.show()
#
#
#func _on_body_exited(body):
	#if body.is_in_group("player"):
		#$WeaponScene/talk.hide()
		
