extends Area2D


func _on_body_entered(body):
	if body.is_in_group("player"):
		print("coin collected")
		if Globalvar.level == 1:
			Coincounter.num += 10
		if Globalvar.level == 2:
			Coincounter.num += 15
		if Globalvar.level == 3:
			Coincounter.num += 20
		Globalvar.first += 1
		Globalvar.collected = true
		$Collect.play()
		$Sprite2D.hide()
		$CoinSprite.hide()
		$Arrow.hide()
		Globalvar.arrow_num += 2
		if Globalvar.level >= 1:
			Globalvar.arrow_num += 3
		await $Collect.finished
		queue_free()
