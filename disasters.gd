extends StaticBody2D

var disaster_state = "none"
const disasters = ["acid", "storm", "meteor", "earthquake", "fog"]

# Called when the node enters the scene tree for the first time.
func _ready():
	hide_all()
	print("New game!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hide_all()
	if disaster_state == "acid":
		$disaster_techs/acid_rain_tech/acid_rain.visible = true
		$acid_tint.visible = true
	elif disaster_state == "storm":
		$disaster_techs/lightning_tech/storm_rain.visible = true
		$storm_tint.visible = true
	elif disaster_state == "meteor":
		$disaster_techs/meteor_tech/meteor_storm.visible = true
		$meteor_tint.visible = true
	elif disaster_state == "earthquake":
		Global.shake = "true"
	elif disaster_state == "fog":
		Global.fog = "true"


func _on_weather_timer_timeout():
	if disaster_state == "none":
		disaster_state = disasters[randi() % disasters.size()]
		$weather_timer.wait_time = randi_range(60,120)
		$weather_timer.start()
		disaster_state = "fog"
		if disaster_state == "storm":
			print("thunder")
			thunder_strike()
		elif disaster_state == "acid":
			print("acid")
		elif disaster_state == "meteor":
			print("meteor")
		elif disaster_state == "earthquake":
			print("earthquake")
		elif disaster_state == "fog":
			Global.fog = "true"
			$disaster_techs/fog_tech/fog/fog_timer.wait_time = 5
			$disaster_techs/fog_tech/fog/fog_timer.start()
			print("fog")
			
	else:
		disaster_state = "none"
		Global.shake = "false"
		Global.fog = "false"
		$disaster_techs/lightning_tech/lightning_timer.stop()
		$weather_timer.wait_time = 10
		$disaster_techs/fog_tech/fog/fog_timer.wait_time = 5
		$disaster_techs/fog_tech/fog/fog_timer.start()
		$weather_timer.start()


func _on_lightning_timer_timeout():
	thunder_strike()
	
func thunder_strike():
	print("BOOM!")
	var nextWaitTime = randi() % 15 + 5
	$disaster_techs/lightning_tech/thunderFlash.play("lightning")
	$disaster_techs/lightning_tech/lightning_timer.set_wait_time(nextWaitTime)
	$disaster_techs/lightning_tech/lightning_timer.start()

func hide_all():
	$disaster_techs/acid_rain_tech/acid_rain.visible = false
	$acid_tint.visible = false
	$disaster_techs/lightning_tech/storm_rain.visible = false
	$storm_tint.visible = false
	$disaster_techs/meteor_tech/meteor_storm.visible = false
	$meteor_tint.visible = false
	$disaster_techs/fog_tech/fog.visible = false
