extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_restart_button_pressed():
	$RestartButton.hide()
	$QuitButton.hide()
	$GameOverBackground.hide()
	$Background.show
