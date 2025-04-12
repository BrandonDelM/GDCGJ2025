extends StaticBody2D

var disaster_state = "none"
const disasters = ["acid", "storm"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$acid_rain_tech/acid_rain.visible = false
	$acid_rain_tech/weather_tint.visible = false
	$lightning_tech/storm_rain.visible = false
	$lightning_tech/tint_layer/storm_tint.visible = false
	if disaster_state == "none":
		print("new game!")
	elif disaster_state == "acid":
		$acid_rain_tech/acid_rain.visible = true
		$acid_rain_tech/weathertint.visible = true
	elif disaster_state == "storm":
		$lightning_tech/storm_rain.visible = true
		$lightning_tech/tint_layer/storm_tint.visible = true
		thunder_strike()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$acid_rain_tech/acid_rain.visible = false
	$acid_rain_tech/weather_tint.visible = false
	$lightning_tech/storm_rain.visible = false
	$lightning_tech/tint_layer/storm_tint.visible = false
	if disaster_state == "acid":
		$acid_rain_tech/acid_rain.visible = true
		$acid_rain_tech/weather_tint.visible = true
	elif disaster_state == "storm":
		$lightning_tech/storm_rain.visible = true
		$lightning_tech/tint_layer/storm_tint.visible = true


func _on_weather_timer_timeout():
	if disaster_state == "none":
		disaster_state = disasters[randi() % disasters.size()]
		$weather_timer.wait_time = randi_range(60,120)
		$weather_timer.start()
		disaster_state = "storm"
		if disaster_state == "storm":
			print("thunder")
			thunder_strike()
		elif disaster_state == "acid":
			print("acid")
	else:
		disaster_state = "none"
		$lightning_tech/lightning_timer.stop()
		$weather_timer.wait_time = 10
		$weather_timer.start()


func _on_lightning_timer_timeout():
	thunder_strike()
	
func thunder_strike():
	print("BOOM!")
	var nextWaitTime = randi() % 15 + 5
	$lightning_tech/thunderFlash.play("lightning")
	$lightning_tech/lightning_timer.set_wait_time(nextWaitTime)
	$lightning_tech/lightning_timer.start()
