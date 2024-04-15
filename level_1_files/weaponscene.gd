extends Control

var in_area = false
var index = 0 
var abase = 0
var amaxlimit = 1
var ibase = 0
var imaxlimit = 1
var dbase = 0
var dmaxlimit = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/Arrow_Shop/AUpgrade/Limit.text = str(amaxlimit)
	$CanvasLayer/Arrow_Shop/IUpgrade/Limit.text = str(imaxlimit)
	$CanvasLayer/Arrow_Shop/DUpgrade/Limit.text = str(dmaxlimit)

func _process(delta):
	#if Input.is_action_just_released("shop") and in_area: 
			#$Tutorial_Weapon.show()
			#$talk.hide()
			#print("Shop action released")
	#pass
	if index == 0:
		$CanvasLayer/Arrow_Shop/ABack.show()
		$CanvasLayer/Arrow_Shop/IBack.hide()
		$CanvasLayer/Arrow_Shop/DBack.hide()
		$CanvasLayer/Arrow_Shop/back.disabled = true
	if index == 1:
		$CanvasLayer/Arrow_Shop/IBack.show()
		$CanvasLayer/Arrow_Shop/ABack.hide()
		$CanvasLayer/Arrow_Shop/DBack.hide()
		$CanvasLayer/Arrow_Shop/front.disabled = false
		$CanvasLayer/Arrow_Shop/back.disabled = false
	if index == 2:
		$CanvasLayer/Arrow_Shop/DBack.show()
		$CanvasLayer/Arrow_Shop/IBack.hide()
		$CanvasLayer/Arrow_Shop/ABack.hide()
		$CanvasLayer/Arrow_Shop/front.disabled = true

func _on_blacksmith_body_entered(body):
	#pass
	if body.is_in_group("player"):
		if Globalvar.level == 1 or Globalvar.level == 3:
			$talk.show()
			in_area = true
			$Open.disabled = false
			$CanvasLayer/Arrow_Shop/front.disabled = false
			$CanvasLayer/Arrow_Shop/back.disabled = false
			$CanvasLayer/Arrow_Shop/exit.disabled = false
		if Globalvar.in_tut:
			$Tutorial_Weapon.show()
			in_area = true

func _on_blacksmith_body_exited(body):
	#pass
	if body.is_in_group("player"):
		if Globalvar.level == 1 or Globalvar.level == 3:
			$talk.hide()
			$Open.disabled = true
			$CanvasLayer/Arrow_Shop/front.disabled = true
			$CanvasLayer/Arrow_Shop/back.disabled = true
			$CanvasLayer/Arrow_Shop/exit.disabled = true
			in_area = false
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


func _on_exit_pressed():
	$CanvasLayer/Arrow_Shop.hide()
	$talk.show()
	get_tree().paused = false


func _on_buy_pressed():
	if index == 0 and amaxlimit > 0 and (Coincounter.num >= 30):
		print('arrow up 10%')
		Globalvar.adamage = .5
		amaxlimit -= 1
		$CanvasLayer/Arrow_Shop/AUpgrade/Limit.text = str(amaxlimit)
		Coincounter.num -= 30
	else:
		$CanvasLayer/NoCoins.show()
		$NocoinTimer.start(1)
		
	if index == 1 and imaxlimit > 0 and (Coincounter.num >= 50):
		print('iron up 10%')
		Globalvar.idamage = .5
		imaxlimit -= 1
		$CanvasLayer/Arrow_Shop/IUpgrade/Limit.text = str(imaxlimit)
		Coincounter.num -= 50 
	else:
		print("Don't have enough coins")
		$CanvasLayer/NoCoins.show()
		$NocoinTimer.start(1)
		
	if index == 2 and dmaxlimit > 0 and (Coincounter.num >= 70):
		print('diamond up 10%')
		Globalvar.ddamage = .5
		dmaxlimit -= 1
		$CanvasLayer/Arrow_Shop/DUpgrade/Limit.text = str(dmaxlimit)
		Coincounter.num -= 70 
	else:
		print("Don't have enough coins")
		$CanvasLayer/NoCoins.show()
		$NocoinTimer.start(1)


func _on_back_pressed():
	index -= 1
	print("back is working")


func _on_front_pressed():
	index += 1
	print("front is working")


func _on_open_pressed():
	if in_area:
		print("button pressed")
		get_tree().paused = true
		$CanvasLayer/Arrow_Shop.show()


func _on_nocoin_timer_timeout():
	$CanvasLayer/NoCoins.hide()
