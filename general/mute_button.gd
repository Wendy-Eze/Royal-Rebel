extends TextureButton

var isMuted = false


func _ready():
	$Music.play()
		

func _process(delta):
	if Globalvar.level == 4 and not Globalvar.king_dead:
		$Music.set_volume_db(-80)
		
	if Globalvar.king_dead:
		$Music.set_volume_db(-35)

func _on_pressed():
	_make_mute()

func _make_mute():
	isMuted = !isMuted
	if isMuted:
		$Music.set_volume_db(-80)
	else:
		$Music.set_volume_db(-35)
