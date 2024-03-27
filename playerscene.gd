extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D/CollisionShape2D.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Globalvar.missions == 0:
		$Area2D/CollisionShape2D.disabled = false
		Globalvar.missions += 1
		


func _on_area_2d_body_entered(body):
	if body.is_in_group("player") and not Globalvar.in_dungeon:
		Globalvar.entered_kingdom = true
		$Timer.start()

func _on_timer_timeout():
	Globalvar.entered_kingdom = false
	Globalvar.playertimerout = true
	$Area2D/CollisionShape2D.disabled = true
	$Knight.show()
	$Timer2.start()

func _on_timer_2_timeout():
	$Knight.hide()
	
