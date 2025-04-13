extends Panel

@onready var fade_timer : Timer = $fog_timer

func _process(delta):
	if (Global.fog == "true"):
		if (fade_timer.wait_time > 0):
			fade_in()
	else:
		if (fade_timer.wait_time > 0):
			fade_out()
	
func fade_in():
	modulate.a = inverse_lerp(fade_timer.wait_time, 0, fade_timer.time_left)
	
func fade_out():
	modulate.a = inverse_lerp(0, fade_timer.wait_time, fade_timer.time_left)
