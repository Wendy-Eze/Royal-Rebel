extends Control

var in_area = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if Input.is_action_just_released("shop") and in_area: 
			#$Tutorial_Weapon.show()
			#$talk.hide()
			#print("Shop action released")
	pass

func _on_blacksmith_body_entered(body):
	#pass
	if body.is_in_group("player"):
		#$talk.show()
		if Globalvar.in_tut:
			$Tutorial_Weapon.show()
			in_area = true

func _on_blacksmith_body_exited(body):
	#pass
	if body.is_in_group("player"):
		#$talk.hide()
		if Globalvar.in_tut:
			in_area = false
			$Tutorial_Weapon.hide()


func _on_arrow_pressed():
	if in_area:
		Globalvar.has_arrow = true
		$Tutorial_Weapon/Arrow.disabled = true
		Globalvar.has_sword = true
		$Tutorial_Weapon/Sword.disabled = true
		$Tutorial_Weapon/Hide.show()
#func _on_sword_pressed():
	#if in_area:
		#Globalvar.has_sword = true
		#$Tutorial_Weapon/Arrow.disabled = true
		##$Tutorial_Weapon/Arrow/S.modulate = Color(89,89,140)
