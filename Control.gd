extends Control
@onready var text_label: Label = $TextLabel
signal start_tut


var dialogue_lines = ["The kingdom of Avalon has been under the stifling rule of the corrupt King Zephyr for many, many years. Citizens of Avalon have been struggling under the weight of increasing taxes and mass incarceration by the kingsmen.", "Anyone against his regime will be thrown into jail , never to see the light of day again. In the shadows, I, the Royal Rebel, bid my time to eventually overthrow the king and return peace to the kingdom.","News has spread that King Zyphyr's plan to turn everyone in Avalon into mindless puppets to do his bidding, using the power of a legendary diadem, thought only to be a myth.","Because the journey is too dangerous for others, I must travel through the kingdom and uncharted wilderness alone to find and destroy the diadem before the kingsmen find it. The legend of the diadem states it is hidden in the Sacred Willow Tree deep in the outskirts of the kingdom, guarded by a fierce dragon..."]
var current_line = -1

#var dialogue_lines = [
	#"The kingdom of Avalon has been under the stifling rule of the corrupt King Zephyr for many, many years. Citizens of Avalon have been struggling under the weight of increasing taxes and mass incarceration by the kingsmen.",
	#"Anyone against his regime will be thrown into jail, never to see the light of day again. In the shadows, you, the Royal Rebel, bid your time to eventually overthrow the king and return peace to the kingdom.",
	##"Among the king’s many victims, my young brother is locked in his dungeon.",
	#"News has spread that King Zephyr plans to turn everyone in Avalon into mindless puppets to do his bidding, using the power of a legendary Diadem, thought only to be a myth.",
	#"Because the journey is too dangerous for others, you must travel through the kingdom and uncharted wilderness alone to find and destroy the diadem before the kingsmen find it. The legend of the Diadem states it is hidden in the Sacred Willow Tree deep in the outskirts of the kingdom, guarded by a fierce dragon..."]
#var current_line = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$TextLabel.text = dialogue_lines[-1]
	#grab_focus()
	
func advance_text():
	   # Increment a counter to move to the next line in your dialogue_lines array
	current_line += 1

	# Check if there are more lines of dialogue to display
	if current_line < dialogue_lines.size():
		# Update the text in the Label node to display the next line of dialogue
		$TextLabel.text = dialogue_lines[current_line]
		print(current_line)
		
		match current_line:
			1:
				$One.hide()
				$Two.show()
				$Three.hide()
				$Four.hide()
			2:
				$One.hide()
				$Two.hide()
				$Three.show()
				$Four.hide()
			3:
				$One.hide()
				$Two.hide()
				$Three.hide()
				$Four.show()
	else:
		# If there are no more lines of dialogue, hide the Label node or perform any other necessary actions
		$TextLabel.hide()
		$One.hide()
		$Two.hide()
		$Three.hide()
		$Four.hide()
		start_tut.emit()
	print("Advancing to the next line of text...")
	
#func input(event):
	#if event is InputEventKey:
		#if event.scancode == KEY_SPACE and event.pressed:
			## Advance to the next line or textbox of text
			#advance_text()
	
#func get_input():
	#if Input.is_action_just_pressed("next_line"):
		#advance_text()
		#print('Spacebar pressed')  # Add this line to check if the function is being called
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("next_line"):
		advance_text()


func _on_skip_pressed():
	start_tut.emit()
