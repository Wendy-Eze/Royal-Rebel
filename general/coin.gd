extends Area2D


func _on_body_entered(body):
	if body.is_in_group("player"):
		print("coin collected")
		Coincounter.num += 10
		Globalvar.first += 1
		Globalvar.collected = true
		$Collect.play()
		$Sprite2D.hide()
		$CoinSprite.hide()
		await $Collect.finished
		queue_free()
