extends Control

var hmaxlimit = 2
var hbase = 0
var ibase = 0
var imaxlimit = 1
var in_area = false
var index = 0

func _ready():
	if Globalvar.level == 3:
		imaxlimit = 3
		hmaxlimit = 4
	$PotionMenu/Health/Limit.text = str(hmaxlimit)
	$PotionMenu/Invisibility/Limit.text = str(imaxlimit)
	

func _process(delta):
	
	if index == 0:
		$PotionMenu/Hback.show()
		$PotionMenu/Iback.hide()
		$PotionMenu/Right.disabled = false 
		$PotionMenu/Left.disabled = true
	if index == 1:
		$PotionMenu/Iback.show()
		$PotionMenu/Hback.hide()
		$PotionMenu/Right.disabled = true
		$PotionMenu/Left.disabled = false 
	

	#if Input.is_action_just_released("shop") and in_area: 
			#$PotionMenu.show()
			#$talk1.hide()
			#print("Shop action released")

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
	if (hbase <= hmaxlimit) and ((Livecounter.num + 25) < 100) and (Coincounter.num >= 20):
		Coincounter.num -= 20 
		Livecounter.num += 25
		hbase += 1
		$PotionMenu/Health/Limit.text = str(hmaxlimit-1)
	else:
		print("cannot purchase health")


func _on_exit_pressed():
	$PotionMenu.hide()
	$talk1.show()
	get_tree().paused = false


func _on_invisibility_button_pressed():
	if (ibase <= imaxlimit) and (Coincounter.num >= 30):
		Coincounter.num -= 30 
		ibase += 1
		Globalvar.equip_potion = true
		Globalvar.i_num += 1
		$PotionMenu/Invisibility/Limit.text = str(imaxlimit-1)
	else:
		print("cannot purchase ghost")


func _on_open_button_pressed():
	if in_area:
		get_tree().paused = true
		$PotionMenu.show()


func _on_right_pressed():
	index += 1
	print("right is pressed")
	$PotionMenu/Iback.show()
	$PotionMenu/Hback.hide()
	$PotionMenu/Right.disabled = true
	$PotionMenu/Left.disabled = false 
	$PotionMenu/Invisibility/InvisibilityButton.disabled = false
	$PotionMenu/Health/HealthButton.disabled = true


func _on_left_pressed():
	index -= 1
	print("left is pressed")
	$PotionMenu/Hback.show()
	$PotionMenu/Iback.hide()
	$PotionMenu/Right.disabled = false 
	$PotionMenu/Left.disabled = true
	$PotionMenu/Invisibility/InvisibilityButton.disabled = true
	$PotionMenu/Health/HealthButton.disabled = false
