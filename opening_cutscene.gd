extends Node2D

signal start_tut
# Called when the node enters the scene tree for the first time.
func _ready():
	hide() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_control_start_game():
	start_tut.emit()

func start():
	show()
