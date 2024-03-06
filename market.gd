extends Area2D

var hmaxlimit = 2
var hlimit = 0


func _ready():
	$Panel/Limit.text = str(hmaxlimit)
	
func _physics_process(_delta):
	if Input.is_action_just_released("shop"):
			$Panel.show()
			$Label.hide()
			print("Shop action released")
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		$Label.show()


func _on_health_button_pressed():
	if (hlimit < hmaxlimit) and ((Livecounter.num + 25) < 100) and (Coincounter.num > 10):
		Coincounter.num -= 10 
		Livecounter.num += 25
		hlimit += 1
		$Panel/Limit.text = str(hmaxlimit-1)
	else:
		print("cannot purchase")

func _on_exit_pressed():
	$Panel.hide()
	$Label.show()

func _on_body_exited(body):
	if body.is_in_group("player"):
		$Label.hide()


func _on_blacksmith_body_entered(body):
	pass # Replace with function body.
