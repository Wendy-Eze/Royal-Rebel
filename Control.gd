extends Control
var dialogue_lines = [
	"The kingdom of Avalon has been under the stifling rule of the corrupt King Zephyr for many, many years. Citizens of Avalon have been struggling under the weight of increasing taxes and mass incarceration by the kingsmen",
	"Anyone against his regime will be thrown into jail , never to see the light of day again. In the shadows, I, the Royal Rebel, bid my time to eventually overthrow the king and return peace to the kingdom.",
	#"Among the king’s many victims, my young brother is locked in his dungeon.",
	"News has spread that King Zyphyr's plan to turn everyone in Avalon into mindless puppets to do his bidding, using the power of a legendary diadem, thought only to be a myth.",
	"Because the journey is too dangerous for others, I must travel through the kingdom and uncharted wilderness alone to find and destroy the diadem before the kingsmen find it. The legend of the diadem states it is hidden in the Sacred Willow Tree deep in the outskirts of the kingdom, guarded by a fierce dragon."]
var current_line = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextLabel.text = dialogue_lines[0]
	
func advance_text():
	   # Increment a counter to move to the next line in your dialogue_lines array
	current_line += 1

	# Check if there are more lines of dialogue to display
	if current_line < dialogue_lines.size() -1:
		# Update the text in the Label node to display the next line of dialogue
		$TextLabel.text = dialogue_lines[current_line]
	else:
		# If there are no more lines of dialogue, hide the Label node or perform any other necessary actions
		$TextLabel.hide()
	print("Advancing to the next line of text...")
	
func get_input():
	#if event is InputEventKey:
		#if event.scancode == KEY_SPACE and event.pressed:
			## Advance to the next line or textbox of text
			#advance_text()
			
	if Input.is_action_just_pressed("next_line"):
		advance_text()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
