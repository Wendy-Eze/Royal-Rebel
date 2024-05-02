extends Node


var bdialogue = [
	"We have arrived at the Enchanted Forest",
	"There's a mystical tree at the end of the forest.",
	"If you defeat all the monsters in the area. A portal will appear at the tree taking you to the dragon.",
	"Be wary! The king is in control of the dragon. Defeat the dragon and you'll defeat the king!",
	"I shall go now! I may have some potions for you, find me at my hut."
]
var index = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.scale *= 0.6
	Goblinkill.num = 0
	Globalvar.level = 3
	Globalvar.witch_shown = false 
	$CanvasLayer/Timer.start()
	$CanvasLayer/WitchDialogue.show()
	$CanvasLayer/WitchIcon.show()
	Globalvar.blindknight = false
	Globalvar.has_armor = true
	Globalvar.has_arrow = true 
	Globalvar.has_sword = true
	Globalvar.equip_arrow = false
	Globalvar.equip_sword = false
	get_tree().paused = false
	#pass # Replace with function body.

func dialogue():
	if index < bdialogue.size():
		$CanvasLayer/WitchDialogue.text = bdialogue[index]
		$CanvasLayer/Timer.start(5)
		index += 1
	else:
		$CanvasLayer/Timer.stop()
		$CanvasLayer/WitchDialogue.hide() 
		$CanvasLayer/WitchIcon.hide()
		$Witch2.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Player/Camera2D.enabled = true
	$Player/TutCam.enabled = false
	$Player/Final.enabled = false
	
	if Goblinkill.num >= Globalvar.limit:
		$Portal/CollisionShape2D.disabled = false
		$Portal.show()
		$Portal/Sound.play()
		$CanvasLayer/Label.show()
		$level_done_sound.play()
	else:
		$Portal/CollisionShape2D.disabled = true
		$level_done_sound.play()
		

#
func _on_timer_timeout():
	if index < bdialogue.size():
		$CanvasLayer/WitchDialogue.text = bdialogue[index]
		$CanvasLayer/Timer.start(5)
		index += 1
	else:
		$CanvasLayer/Timer.stop()
		$CanvasLayer/WitchDialogue.hide() 
		$CanvasLayer/WitchIcon.hide()
		$Witch2.hide()


func _on_button_pressed():
	dialogue()
	#index += 1


func _on_portal_body_entered(body):
	if body.is_in_group("player"):
		print("detected")
		get_tree().change_scene_to_file("res://final_boss.tscn")
		
func play_next_level_sound():
	$next_level_sound.play()
