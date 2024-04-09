extends Control

@onready var arrow = $Container/Arrow.get_theme_stylebox("panel")
@onready var sword = $Container/Sword.get_theme_stylebox("panel")
@onready var gold = $Container/GoldSword.get_theme_stylebox("panel")
@onready var diamond = $Container/DiamondSword.get_theme_stylebox("panel")
var cooldownactive = false

func _ready():
	$Container/Potion/Label.text = " "
	$Container/Arrow/Cooldown.text = " "

func _process(delta):
	$Container/Arrow/ArrowLimit.text = str(Globalvar.arrow_num)
	
	if Globalvar.arrow_num == 0:
		Globalvar.ready_arrow = false
	
	#if Globalvar.has_goldsword:
		#$Container/GoldSword/Sprite2D.show()
	if Globalvar.has_diamondsword:
			$Container/Sword/Diamond.show()
			$Container/Sword/Sprite2D.hide()
	
	if Globalvar.has_armor:
		$Container/Armor/Sprite2D.show()
		
	if Input.is_action_pressed("arrow"):
		Globalvar.equip_arrow = true
		Globalvar.equip_sword = false
		Globalvar.equip_gold = false 
		Globalvar.equip_diamond = false 
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
		
		diamond.border_width_bottom = 0
		diamond.border_width_top = 0
		diamond.border_width_right = 0
		diamond.border_width_left = 0
		add_theme_stylebox_override("panel", diamond)
		
		gold.border_width_bottom = 0
		gold.border_width_top = 0
		gold.border_width_right = 0
		gold.border_width_left = 0
		add_theme_stylebox_override("panel", gold)

	if Input.is_action_just_pressed("sword"):
		Globalvar.equip_arrow = false
		Globalvar.equip_sword = true
		Globalvar.equip_gold = false 
		Globalvar.equip_diamond = false 
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
		
		diamond.border_width_bottom = 0
		diamond.border_width_top = 0
		diamond.border_width_right = 0
		diamond.border_width_left = 0
		add_theme_stylebox_override("panel", diamond)
		
		gold.border_width_bottom = 0
		gold.border_width_top = 0
		gold.border_width_right = 0
		gold.border_width_left = 0
		add_theme_stylebox_override("panel", gold)
		
	if Input.is_action_just_pressed("gold") and Globalvar.has_goldsword:
		print("pressed gold")
		Globalvar.equip_arrow = false
		Globalvar.equip_sword = false
		Globalvar.equip_gold = true 
		Globalvar.equip_diamond = false 
		gold.border_color = Color(255,255,255)
		gold.border_width_bottom = 5
		gold.border_width_top = 5
		gold.border_width_right = 5
		gold.border_width_left = 5
		add_theme_stylebox_override("panel", gold)
		
		arrow.border_width_bottom = 0
		arrow.border_width_top = 0
		arrow.border_width_right = 0
		arrow.border_width_left = 0
		add_theme_stylebox_override("panel", arrow)
		
		sword.border_width_bottom = 0
		sword.border_width_top = 0
		sword.border_width_right = 0
		sword.border_width_left = 0
		add_theme_stylebox_override("panel", sword)
		
		diamond.border_width_bottom = 0
		diamond.border_width_top = 0
		diamond.border_width_right = 0
		diamond.border_width_left = 0
		add_theme_stylebox_override("panel", diamond)
	
	if Input.is_action_just_pressed("diamond") and Globalvar.has_diamondsword:
		Globalvar.equip_arrow = false
		Globalvar.equip_sword = false
		Globalvar.equip_gold = false 
		Globalvar.equip_diamond = true 
		diamond.border_color = Color(255,255,255)
		diamond.border_width_bottom = 5
		diamond.border_width_top = 5
		diamond.border_width_right = 5
		diamond.border_width_left = 5
		add_theme_stylebox_override("panel", diamond)
		
		arrow.border_width_bottom = 0
		arrow.border_width_top = 0
		arrow.border_width_right = 0
		arrow.border_width_left = 0
		add_theme_stylebox_override("panel", arrow)
		
		sword.border_width_bottom = 0
		sword.border_width_top = 0
		sword.border_width_right = 0
		sword.border_width_left = 0
		add_theme_stylebox_override("panel", sword)
		
		gold.border_width_bottom = 0
		gold.border_width_top = 0
		gold.border_width_right = 0
		gold.border_width_left = 0
		add_theme_stylebox_override("panel", gold)
	
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
	
	if Globalvar.armor_equipped and Globalvar.level == 2:
		if Input.is_action_just_pressed("knight"):
			#Globalvar.i_num -= 1
			Globalvar.is_invisible = true
			$Container/Armor/Countdown.show()
			$Container/Armor/Timer.show()
			$Container/Armor/Timer2.start()
			
	#else:
		#$Container/Potion/Sprite2D.hide()
		#$Container/Potion/Label.text = " "
	#$Container/Potion/Timer.text = str($Container/Potion/Timer2.time_left)
	$Container/Armor/Timer.text = "%d" % [int($Container/Armor/Timer2.time_left)]


func _on_timer_2_timeout():
	Globalvar.is_invisible = false
	$Container/Potion/Countdown.hide()
	$Container/Potion/Timer.hide()
	
	$Container/Armor/Countdown.hide()
	$Container/Armor/Timer.hide()
	#if not Globalvar.equip_potion and Globalvar.i_num == 0:
	#$Container/Potion/Sprite2D.hide()

#func startcooldown():
	#cooldownactive = true
	##if cooldownactive:
	#$Container/Arrow/ArrowCooldown.start()
	#$Container/Arrow/Cooldown.show()
	#print($Container/Arrow/ArrowCooldown.time_left)
	#$Container/Arrow/Cooldown.text = "%d" % [int($Container/Arrow/ArrowCooldown.time_left)]
#
#func _on_arrow_cooldown_timeout():
	##Globalvar.arrow_num = 15
	#$Container/Arrow/Cooldown.hide()
	#print("Arrow cooldown timer completed.")
	#$Container/Arrow/Cooldown.text = " "
	#cooldownactive = false
