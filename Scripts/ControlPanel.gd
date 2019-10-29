extends CanvasLayer



var out = true

func _on_Back_pressed():
	if out:
		$ColorRect/AnimationPlayer.play("exit")
		out = false
	else:
		$ColorRect/AnimationPlayer.play("enter")
		out = true

func _on_Miner_pressed():
	pass # Replace with function body.
