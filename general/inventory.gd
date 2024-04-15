extends Control

@onready var arrow = $Container/Arrow.get_theme_stylebox("panel")
@onready var sword = $Container/Sword.get_theme_stylebox("panel")
@onready var gold = $Container/GoldSword.get_theme_stylebox("panel")
@onready var diamond = $Container/DiamondSword.get_theme_stylebox("panel")
var cooldownactive = false
var armorcool = false

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
	if Globalvar.has_arrow:
		$Container/Arrow/Sprite2D.show()
	if Globalvar.has_sword:
		$Container/Sword/Sprite2D.show()
		
	if Input.is_action_pressed("arrow") and Globalvar.has_arrow:
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

	if Input.is_action_just_pressed("sword") and Globalvar.has_sword:
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
	
	if Globalvar.has_armor and Globalvar.level == 2 and not armorcool:
		if Input.is_action_just_pressed("knight"):
			#Globalvar.i_num -= 1
			#armorcool = true
			Globalvar.is_invisible = true
			Globalvar.armor_equipped = true
			$Container/Armor/Countdown.show()
			$Container/Armor/Timer.show()
			$Container/Armor/Timer2.start(6)
			
	$Container/Armor/Timer.text = "%d" % [int($Container/Armor/Timer2.time_left)]
	
	if armorcool:
		$Container/Armor/Hide.show()
		#$Container/Armor/Cool.start(5)
	else:
		$Container/Armor/Hide.hide()
		#$Container/Armor/Cool.stop()

func _on_timer_2_timeout():
	Globalvar.is_invisible = false
	$Container/Potion/Countdown.hide()
	$Container/Potion/Timer.hide()
	
	$Container/Armor/Countdown.hide()
	$Container/Armor/Timer.hide()
	Globalvar.armor_equipped = false
	armorcool = true
	$Container/Armor/Cool.start(5)
	
	print("timer2 done")

func _on_cool_timeout():
	armorcool = false
	print("cool done")
