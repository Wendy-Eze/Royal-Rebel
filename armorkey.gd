extends Sprite2D

#
#var is_dragging = false
#var ipos : Vector2
#
#func _process(delta):
	#if Input.is_action_just_pressed("drag"):
		#ipos = global_position
		#offset = get_global_mouse_position() - global_position
		#is_dragging = true
	#if Input.is_action_pressed("drag"):
		#global_position = get_global_mouse_position() - offset
