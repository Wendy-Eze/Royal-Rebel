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
		$TileMap/Open.tile_set.set_physics_layer_collision_layer(0,0)
		$TileMap/Open.tile_set.set_physics_layer_collision_mask(0,0)
		$TileMap/Closed.tile_set.set_physics_layer_collision_layer(0,0)
		$TileMap/Closed.tile_set.set_physics_layer_collision_mask(0,0)
		$DocArea/CollisionShape2D.disabled = true
		$Prisoners/P6/NPCArea/CollisionShape2D.disabled = true
		$Prisoners/P8/NPCArea/CollisionShape2D.disabled = true
		$Prisoners/P1/NPCArea/CollisionShape2D.disabled = true
	if Globalvar.in_dungeon:
		$TileMap.tile_set.set_physics_layer_collision_mask(0,1)
		$TileMap.tile_set.set_physics_layer_collision_layer(0,1)
		$TileMap/Open.tile_set.set_physics_layer_collision_layer(0,1)
		$TileMap/Open.tile_set.set_physics_layer_collision_mask(0,1)
		$TileMap/Closed.tile_set.set_physics_layer_collision_layer(0,1)
		$TileMap/Closed.tile_set.set_physics_layer_collision_mask(0,1)
		$DocArea/CollisionShape2D.disabled = false
		$Prisoners/P6/NPCArea/CollisionShape2D.disabled = false
		$Prisoners/P8/NPCArea/CollisionShape2D.disabled = false
		$Prisoners/P1/NPCArea/CollisionShape2D.disabled = false
		
	if Globalvar.mission_done:
		$TileMap/Open.show()
		$TileMap/Closed.hide()


func _on_doc_area_body_entered(body):
	if body.is_in_group("player"):
		if not talk_started and not Globalvar.has_key:
			$DoctorDialogue/Text.show()
			$Timer.start()
			$DoctorDialogue/Button.show()
		if Globalvar.has_key:
			talk_started = true
			$DoctorDialogue/Text2.show()
			$DoctorDialogue/Button.show()
			$Timer.start()

func _on_timer_timeout():
	if not Globalvar.has_key:
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
		
	
	if Globalvar.has_key:
		if index2 < dialogue2.size():
			$DoctorDialogue/Text2.text = dialogue2[index2]
			$Timer.start(5)
			index2 += 1
		else:
			$Timer.stop()
			$DoctorDialogue/Text2.hide()
			$DoctorDialogue/NPC.hide()
			Globalvar.mission_done = true


func _on_lock_body_entered(body):
	if body.is_in_group("player"):
		if Globalvar.mission_done:
			$TileMap/ArmoryClosed.hide()
			$TileMap/ArmoryClosed/Sprite2D/Lock/CollisionShape2D.disabled = true
			$TileMap/ArmoryClosed.tile_set.set_physics_layer_collision_mask(0,0)
			$TileMap/ArmoryClosed.tile_set.set_physics_layer_collision_layer(0,0)
			Globalvar.unlocked_armory = true


func _on_arrows_button_pressed():
	if Globalvar.mission_done:
		Globalvar.arrow_num += 20
		$Node/Arrows/ArrowsButton.disabled = true
		$Node/Arrows.hide()

func _on_diamond_button_pressed():
	if Globalvar.mission_done:
		Globalvar.has_diamondsword = true
		$Node/DiamondSword/DiamondButton.disabled = true
		$Node/DiamondSword.hide()


func _on_coin_button_pressed():
	if Globalvar.mission_done:
		Coincounter.num += 15
		$Node/CoinButton.hide()
		$Node/CoinButton.disabled = true


func _on_npc_area_body_entered(body):
	if body.is_in_group("player"):
		$Prisoners/P1/Label.show()
		$Prisoners/P6/Label.show()
		$Prisoners/P8/Label.show()

func _on_npc_area_body_exited(body):
	if body.is_in_group("player"):
		$Prisoners/P1/Label.hide()
		$Prisoners/P6/Label.hide()
		$Prisoners/P8/Label.hide()


func _on_doc_area_body_exited(body):
	if body.is_in_group("player"):
		index2 = 5
		index = 5
		talk_started = false
		$DoctorDialogue/Text.hide()
		$DoctorDialogue/Text.hide()
		$DoctorDialogue/Button.hide()
		$DoctorDialogue/NPC.hide()

func message():
	if not Globalvar.has_key:
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
			$DoctorDialogue/Button.hide()
		
	
	if Globalvar.has_key:
		if index2 < dialogue2.size():
			$DoctorDialogue/Text2.text = dialogue2[index2]
			$Timer.start(5)
			index2 += 1
		else:
			$Timer.stop()
			$DoctorDialogue/Text2.hide()
			$DoctorDialogue/NPC.hide()
			$DoctorDialogue/Button.hide()
			Globalvar.mission_done = true

func _on_button_pressed():
	print("button pressed")
	message()
