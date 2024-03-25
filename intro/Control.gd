extends Control
@onready var text_label: Label = $TextLabel
signal start_tut


var dialogue_lines = []
var current_line = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func advance_text():
	   # Increment a counter to move to the next line in your dialogue_lines array
	current_line += 1

	# Check if there are more lines of dialogue to display
	if current_line != 7:
		# Update the text in the Label node to display the next line of dialogue
		match current_line:
			2:
				$One.hide()
				$Two.show()
				$Three.hide()
				$Four.hide()
			4:
				$One.hide()
				$Two.hide()
				$Three.show()
				$Four.hide()
			5:
				$One.hide()
				$Two.hide()
				$Three.hide()
				$Four.show()
	elif current_line == 7:
		# If there are no more lines of dialogue, hide the Label node or perform any other necessary actions
		$TextLabel.hide()
		$One.hide()
		$Two.hide()
		$Three.hide()
		$Four.hide()
		start_tut.emit()
	print("Advancing to the next line of text...")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("next_line"):
		advance_text()


func _on_skip_pressed():
	start_tut.emit()
