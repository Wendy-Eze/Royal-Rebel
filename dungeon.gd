extends Node

var dialogue = [
	"Pssst! Royal Rebel! Come over here… quietly...",
	" ",
	"I see that you have spoken to my messenger. You see I was captured while secretly sneaking into the castle to heal the hurt prisoners",
	"Please retrieve the key and set us free!",
	"I have something that may be helpful to you and we can cause a distraction to allow you time to journey forth!"
]

var dialogue2 = [
	"Thank you!! Here - take this… it's the keys to the guard’s armory! Upgrade your weapons before taking on the king.",
	"VILLAGERS, LET’S GO!!"
]

var talk_started = false 
var index = 0 
var index2 = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	#$Player.scale *= 0.6
	pass


func _process(delta):
	
	if not Globalvar.in_dungeon:
		$TileMap.tile_set.set_physics_layer_collision_mask(0,0)
		$TileMap.tile_set.set_physics_layer_collision_layer(0,0)
		$DocArea/CollisionShape2D.disabled = true
	if Globalvar.in_dungeon:
		$TileMap.tile_set.set_physics_layer_collision_mask(0,1)
		$TileMap.tile_set.set_physics_layer_collision_layer(0,1)
		$DocArea/CollisionShape2D.disabled = false


func _on_doc_area_body_entered(body):
	if body.is_in_group("player"):
		if not talk_started:
			$DoctorDialogue/Text.show()
			$Timer.start()
		if Globalvar.mission_done:
			$DoctorDialogue/Text2.show()
			$Timer.start()

func _on_timer_timeout():
	if index < dialogue.size():
		$DoctorDialogue/Text.text = dialogue[index]
		$Timer.start(5)
		if index == 1:
			$DoctorDialogue/Reply.show()
			$DoctorDialogue/NPC.hide()
		else:
			$DoctorDialogue/Reply.hide()
			$DoctorDialogue/NPC.show()
		index += 1
	else:
		$Timer.stop()
		$DoctorDialogue/Text.hide()
		$DoctorDialogue/NPC.hide()
	
	if Globalvar.mission_done:
		if index2 < dialogue2.size():
			$DoctorDialogue/Text2.text = dialogue[index]
			$Timer.start(5)
			#if index == 1:
				#$DoctorDialogue/Reply.show()
				#$DoctorDialogue/NPC.hide()
			#else:
				#$DoctorDialogue/Reply.hide()
				#$DoctorDialogue/NPC.show()
			index += 1
		else:
			$Timer.stop()
			$DoctorDialogue/Text2.hide()
			$DoctorDialogue/NPC.hide()
