extends Node2D

var dialogue = ["The guards know you are wearing a disguise. Don’t worry, with the help of my powers they can’t see you." ,"I am Sabrina, the great witch of the nation. I can help you get to the king. I shall take you to him through this portal."]
var index = 0
var talk_started = false
#var talk1 = false
#var talk2 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D/CollisionShape2D.disabled = true
	$Portal/CollisionShape2D.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Globalvar.missions == 1:
		$Area2D/CollisionShape2D.disabled = false
		show()


func _on_area_2d_body_entered(body):
	if body.is_in_group("player") and not Globalvar.in_dungeon:
		Globalvar.witch_shown = true
		if not talk_started:
			talk_started = true
			$WitchDialogue/Talk.show()
			$Timer.start()


func _on_timer_timeout():
	#index += 1
	if index < dialogue.size():
		$WitchDialogue/Talk.text = dialogue[index]
		$Timer.start(5)
		index += 1
	else:
		$Timer.stop()
		$WitchDialogue/Talk.hide()
		$Portal.show()
		$Portal/CollisionShape2D.disabled = false
		
func _on_portal_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://level_3.tscn")
