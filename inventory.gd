extends Control

@onready var arrow = $Container/Arrow.get_theme_stylebox("panel")
@onready var sword = $Container/Sword.get_theme_stylebox("panel")
var cooldownactive = false

func _ready():
	$Container/Potion/Label.text = " "
	$Container/Arrow/Cooldown.text = " "

func _process(delta):
	$Container/Arrow/ArrowLimit.text = str(Globalvar.arrow_num)
	
	if Globalvar.arrow_num == 0:
		Globalvar.ready_arrow = false
		
	#if Globalvar.arrow_num == 15 and not cooldownactive:
		#Globalvar.arrow_num = 0
		#Globalvar.ready_arrow = false
		##cooldownactive = true
		##if cooldownactive:
		#startcooldown()
		
	##$Container/Arrow/ArrowCooldown.start()
	##print($Container/Arrow/ArrowCooldown.time_left)
	#if timer_started:
		#$Container/Arrow/ArrowCooldown.start()
		#timer_started = false
		#print($Container/Arrow/ArrowCooldown.time_left)
	#else:
		#pass
	
	if Globalvar.has_armor:
		$Container/Armor/Sprite2D.show()
		
	if Input.is_action_pressed("arrow"):
		Globalvar.equip_arrow = true
		Globalvar.equip_sword = false
		arrow.border_color = Color(255,255,255)
		arrow.border_width_bottom = 5
		arrow.border_width_top = 5
		arrow.border_width_right = 5
		arrow.border_width_left = 5
		add_theme_stylebox_override("panel", arrow)
		
		sword.border_width_bottom = 0
		sword.border_width_top = 0
		sword.border_width_right = 0
		sword.border_width_left = 0
		add_theme_stylebox_override("panel", sword)
		#$Container/Arrow/ArrowCooldown.start()
	#print($Container/Arrow/ArrowCooldown.time_left)
		
		#if Globalvar.arrow_num <= 15 and not Globalvar.ready_arrow:
			#$Container/Arrow/ArrowCooldown.start()
		#print($Container/Arrow/ArrowCooldown.time_left)
		#$Container/Arrow/Cooldown.text = "%d" % [int($Container/Arrow/ArrowCooldown.time_left)]
	#
	if Input.is_action_just_pressed("sword"):
		Globalvar.equip_arrow = false
		Globalvar.equip_sword = true
		sword.border_color = Color(255,255,255)
		sword.border_width_bottom = 5
		sword.border_width_top = 5
		sword.border_width_right = 5
		sword.border_width_left = 5
		add_theme_stylebox_override("panel", sword)
		
		arrow.border_width_bottom = 0
		arrow.border_width_top = 0
		arrow.border_width_right = 0
		arrow.border_width_left = 0
		add_theme_stylebox_override("panel", arrow)
	
	if Globalvar.equip_potion and Globalvar.i_num > 0:
		$Container/Potion/Sprite2D.show()
		$Container/Potion/Label.text = str(Globalvar.i_num)
		if Input.is_action_just_pressed("potion"):
			Globalvar.i_num -= 1
			Globalvar.is_invisible = true
			$Container/Potion/Countdown.show()
			$Container/Potion/Timer.show()
			$Container/Potion/Timer2.start()
			
	else:
		$Container/Potion/Sprite2D.hide()
		$Container/Potion/Label.text = " "
	#$Container/Potion/Timer.text = str($Container/Potion/Timer2.time_left)
	$Container/Potion/Timer.text = "%d" % [int($Container/Potion/Timer2.time_left)]
	
	#if Globalvar.arrow_num == 0:
		#print("num of arrow is zero")


func _on_timer_2_timeout():
	Globalvar.is_invisible = false
	$Container/Potion/Countdown.hide()
	$Container/Potion/Timer.hide()
	#if not Globalvar.equip_potion and Globalvar.i_num == 0:
	#$Container/Potion/Sprite2D.hide()

func startcooldown():
	cooldownactive = true
	#if cooldownactive:
	$Container/Arrow/ArrowCooldown.start()
	$Container/Arrow/Cooldown.show()
	print($Container/Arrow/ArrowCooldown.time_left)
	$Container/Arrow/Cooldown.text = "%d" % [int($Container/Arrow/ArrowCooldown.time_left)]

func _on_arrow_cooldown_timeout():
	#Globalvar.arrow_num = 15
	$Container/Arrow/Cooldown.hide()
	print("Arrow cooldown timer completed.")
	$Container/Arrow/Cooldown.text = " "
	cooldownactive = false
