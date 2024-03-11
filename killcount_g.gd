extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$KillsLeft.text = str(Goblinkill.num) + "/10"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change()
	
func change():
	$KillsLeft.text = str(Goblinkill.num) + "/10"
