extends CanvasLayer

signal start_game

func _ready():
	pass
	

func _process(delta):
	#set_health()
	pass

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Shoot the Peeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)


func _on_start_button_pressed():
	$StartButton.hide()
	$Background.hide()
	start_game.emit()
	$Instruction.show()
	#print("got node")

func _on_message_timer_timeout():
	$Message.hide()
	

#func set_health():
	#$PlayerHealth.value = Livecounter.num
