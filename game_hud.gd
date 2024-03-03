extends CanvasLayer


func _ready():
	pass # Replace with function body.

func _process(delta):
	set_health()

func set_health():
	$PlayerHealth.value = Livecounter.num
