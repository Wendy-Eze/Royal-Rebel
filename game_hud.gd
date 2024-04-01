extends CanvasLayer
var attempts = 0
var instance = 0 
#var first = 0 
var first_done = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	set_health()
	add_coin()
	add_arrow()
	
	if Globalvar.entered_kingdom:
		$Story2/Label.show()
	
	if Globalvar.playertimerout:
		$Story2/Label.hide()
	
	if Globalvar.witch_shown:
		$Shadow.show()
		$Shadow1.show()
	
	if Globalvar.first == 1:
		$CollectTimer.start()
		$Coin_collected.show()
		$Arrow_collected.show()
		Globalvar.first += 1
		first_done = true
		
	if Globalvar.collected and Globalvar.first > 2:
		$CollectTimer.start()
		$Collected.show()
		$Collected2.show()
		Globalvar.collected = false

	if $PlayerHealth.value == 0:
		#get_tree().current_scene.pause()
		$GameOverScreen.show()
		$PlayerHealth.hide()
		$MuteButton.hide()
	
	if Globalvar.level == 1 and attempts == 0:
		$LevelTimer.start()
		$Level1.show()
		attempts += 1
	if Globalvar.level == 2 and attempts == 0:
		$LevelTimer.start()
		$Level2.show()
		attempts += 1
	if Globalvar.level == 3 and attempts == 0:
		$LevelTimer.start()
		$Level3.show()
		attempts += 1

func set_health():
	$PlayerHealth.value = Livecounter.num

func add_coin():
	$CoinDisplay/CoinDisplay.text = str(Coincounter.num)

func add_arrow():
	$ArrowDisplay/ArrowDisplay.text = str(Globalvar.arrow_num)


func _on_menu_button_pressed():
	$Menu.show()
	get_tree().paused = true
	#if $Menu.is_visible():
		#$Menu.hide()
		##get_tree().paused = false
	#else:
		#$Menu.show()
		##get_tree().paused = true

func _on_exit_button_pressed():
	$Menu.hide()
	get_tree().paused = false
		 # Replace with function body.


func _on_level_timer_timeout():
	$Level1.hide()
	$Level2.hide()
	$Level3.hide()
	attempts == 0
	#if Globalvar.level == 1:
		#$Level1.hide()
	#if Globalvar.level == 2:
		#$Level2.hide()
	#if Globalvar.level == 3:
		#$Level3.hide()


func _on_collect_timer_timeout():
	$Coin_collected.hide()
	$Arrow_collected.hide()
	$Collected.hide()
	$Collected2.hide()
	#Globalvar.collected = false
	print("one")


#func _on_story_2_timer_timeout():
	#$Story2/Label.hide()
	#Globalvar.entered_kingdom = false 

