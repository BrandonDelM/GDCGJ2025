extends Panel

func _process(delta):
	if (Global.fog == "true"):
		modulate.a = inverse.lerp(5, 0, 5)
