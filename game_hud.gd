extends CanvasLayer


func _ready():
	pass # Replace with function body.

func _process(delta):
	set_health()
	add_coin()
	add_arrow()

	if $PlayerHealth.value == 0:
		#get_tree().current_scene.pause()
		#$GameOverScreen.show()
		$PlayerHealth.hide()
		$MuteButton.hide()


func set_health():
	$PlayerHealth.value = Livecounter.num

func add_coin():
	$CoinDisplay/CoinDisplay.text = str(Coincounter.num)

func add_arrow():
	$ArrowDisplay/ArrowDisplay.text = str(Globalvar.arrow_num)


func _on_menu_button_pressed():
	if $Menu.is_visible():
		$Menu.hide()
		#get_tree().paused = false
	else:
		$Menu.show()
		#get_tree().paused = true
