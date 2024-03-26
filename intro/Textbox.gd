extends CanvasLayer

const CHAR_READ_RATE = 0.035

@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label
@onready var tween = get_tree().create_tween()


enum State {
	READY,
	READING, 
	FINISHED
}

var current_state = State.READY
var text_queue = []

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Starting state: State.READY")
	hide_textbox()
	queue_text("The kingdom of Avalon has been under the stifling rule of the corrupt King Zephyr")
	queue_text("for many, many years.")
	queue_text("Citizens of Avalon have been struggling under the weight of increasing taxes and mass")
	queue_text("incarceration by the kingsmen.")
	queue_text("Anyone against his regime will be thrown into jail, never to see the light of day again.")
	queue_text("News has spread that King plans to turn everyone in Avalon into mindless puppets to do")
	queue_text("his bidding using the power of a legendary Diadem, thought only to be a myth.")
	queue_text("Because the journey is too dangerous for others, you, the Royal Rebel, must travel")
	queue_text("through uncharted wilderness alone...")
	queue_text("...to find and destroy the diadem before the King finds it!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				display_text()
		State.READING:
			if Input.is_action_just_pressed("next_line"):
				tween.kill()
				label.visible_characters = -1
				end_symbol.text = "->"
				change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("next_line"):
				change_state(State.READY)
				hide_textbox()

func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()
	
func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()
	
func display_text():
	tween = get_tree().create_tween()
	var next_text = text_queue.pop_front()
	label.text = next_text
	change_state(State.READING)
	show_textbox()
	tween.tween_property(label, "visible_characters", len(next_text), len(next_text) * CHAR_READ_RATE).from(0).finished
	tween.connect("finished", on_tween_finished)
	end_symbol.text = "..." 
	
func on_tween_finished():
	end_symbol.text = "->"
	change_state(State.FINISHED)
	
func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: State.READY")
		State.READING:
			print("Changing state to: State.READING")
		State.FINISHED:
			print("Changing state to: State.FINISHED")
