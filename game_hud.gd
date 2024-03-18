extends CanvasLayer


func _ready():
	pass # Replace with function body.

func _process(delta):
	set_health()
	add_coin()
	if $PlayerHealth.value == 0:
		#get_tree().current_scene.pause()
		$GameOverScreen.show()
		$PlayerHealth.hide()
		$MuteButton.hide()

func set_health():
	$PlayerHealth.value = Livecounter.num

func add_coin():
		$CoinDisplay/CoinDisplay.text = str(Coincounter.num)
