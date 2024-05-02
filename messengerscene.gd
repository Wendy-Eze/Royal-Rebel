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
var attempt = 0

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
			$MessengerDialogue/Button.show()
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
		if index == 4:
			$MessengerDialogue/Statue.show()
		else:
			$MessengerDialogue/Statue.hide()
		index += 1
	else:
		$Timer.stop()
		$MessengerDialogue/Text.hide()
		$MessengerDialogue/NPC.hide()
		$MessengerDialogue/Statue.hide()
		$MessengerDialogue/Button.hide()
		
func message():
	if index < dialogue.size():
		$MessengerDialogue/Text.text = dialogue[index]
		$Timer.start(5)
		if index == 2:
			$MessengerDialogue/Reply.show()
			$MessengerDialogue/NPC.hide()
		else:
			$MessengerDialogue/Reply.hide()
			$MessengerDialogue/NPC.show()
		if index == 4:
			$MessengerDialogue/Statue.show()
		else:
			$MessengerDialogue/Statue.hide()
		index += 1
	else:
		$Timer.stop()
		$MessengerDialogue/Text.hide()
		$MessengerDialogue/NPC.hide()
		$MessengerDialogue/Statue.hide()
		$MessengerDialogue/Button.hide()

func _on_start_body_exited(body):
	if body.is_in_group("player"):
		index = 5
		talk_started = false
		$MessengerDialogue/Text.hide()
		$MessengerDialogue/Reply.hide()
		$MessengerDialogue/NPC.hide()
		$MessengerDialogue/Button.hide()
		$MessengerDialogue/Statue.hide()
		$Timer.stop()
		if attempt == 0:
			$MessengerDialogue/Mission2.show()
			attempt += 1


func _on_button_pressed():
	message()
