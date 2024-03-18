extends Control

var hmaxlimit = 2
var hbase = 0
var ibase = 0
var imaxlimit = 1
var in_area = false

func _ready():
	$PotionMenu/Health/Limit.text = str(hmaxlimit)
	$PotionMenu/Invisibility/Limit.text = str(imaxlimit)
	
#func _physics_process(_delta):

			
func _process(delta):
	#if in_area == true:
	if Input.is_action_just_released("shop") and in_area: 
			$PotionMenu.show()
			print("Shop action released")

func _on_witch_body_entered(body):
	if body.is_in_group("player"):
		$talk1.show()
		in_area = true


func _on_witch_body_exited(body):
	if body.is_in_group("player"):
		$talk1.hide()
		in_area = false
		$PotionMenu.hide()

func _on_health_button_pressed():
	if (hbase < hmaxlimit) and ((Livecounter.num + 25) < 100) and (Coincounter.num > 20):
		Coincounter.num -= 20 
		Livecounter.num += 25
		hbase += 1
		$PotionMenu/Health/Limit.text = str(hmaxlimit-1)
	else:
		print("cannot purchase health")


func _on_exit_pressed():
	$PotionMenu.hide()


func _on_invisibility_button_pressed():
	if (ibase < imaxlimit) and (Coincounter.num > 10):
		Coincounter.num -= 10 
		ibase += 1
		Globalvar.equip_potion = true
		Globalvar.i_num += 1
		$PotionMenu/Invisibility/Limit.text = str(imaxlimit-1)
	else:
		print("cannot purchase ghost")
