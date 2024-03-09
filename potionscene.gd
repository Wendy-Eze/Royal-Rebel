extends Control

var hmaxlimit = 2
var hlimit = 0
var in_area = false

func _ready():
	$Panel/Limit.text = str(hmaxlimit)
	
#func _physics_process(_delta):

			
func _process(delta):
	#if in_area == true:
	if Input.is_action_just_released("shop") and not in_area: 
			$Panel.show()
			print("Shop action released")

func _on_witch_body_entered(body):
	if body.is_in_group("player"):
		$talk1.show()
		in_area = true


func _on_witch_body_exited(body):
	if body.is_in_group("player"):
		$talk1.hide()
		in_area = false

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
