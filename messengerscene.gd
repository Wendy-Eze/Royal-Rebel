extends Node2D

var dialogue = [
	"Hey, you!",
	"You're the Royal Rebel, aren't you?",
	"",
	"I ask because the doctor will like to see you, but you see, he has been captured!",
	"Sneak into to the dungeon. Find these three statues!"
]
var index = 0
var talk_started = false


func _ready():
	pass

func _process(delta):
	pass


func _on_start_body_entered(body):
	if body.is_in_group("player"): 
		if not talk_started:
			index = 0
			talk_started = true
			$MessengerDialogue/Text.show()
			$MessengerDialogue/NPC.show()
			$Timer.start()

func _on_timer_timeout():
	if index < dialogue.size():
		$MessengerDialogue/Text.text = dialogue[index]
		$Timer.start(5)
		if index == 2:
			$MessengerDialogue/Reply.show()
			$MessengerDialogue/NPC.hide()
		else:
			$MessengerDialogue/Reply.hide()
			$MessengerDialogue/NPC.show()
		index += 1
	else:
		$Timer.stop()
		$MessengerDialogue/Text.hide()
		$MessengerDialogue/NPC.hide()


func _on_start_body_exited(body):
	if body.is_in_group("player"):
		index = 5
		talk_started = false
		$MessengerDialogue/Text.hide()
		$MessengerDialogue/NPC.hide()
		$Timer.stop()
