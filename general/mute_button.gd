extends TextureButton

var isMuted = false


func _ready():
	$Music.play()
		

func _process(delta):
	pass

func _on_pressed():
	_make_mute()

func _make_mute():
	isMuted = !isMuted
	if isMuted:
		$Music.set_volume_db(-80)
	else:
		$Music.set_volume_db(-35)
