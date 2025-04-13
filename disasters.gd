extends StaticBody2D

var disaster_state = "none"
const disasters = ["acid", "storm", "meteor", "earthquake", "fog", "blizzard", "heatwave"]
var fog_state = "false"

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
		$disaster_techs/fog_tech/fog.visible = true
		fade_in()
	elif disaster_state == "blizzard":
		$blizzard_tint.visible = true
		$disaster_techs/blizzard_tech/blizzard_storm.visible = true
	elif disaster_state == "heatwave":
		$heatwave_tint.visible = true

func _on_weather_timer_timeout():
	if disaster_state == "none":
		disaster_state = disasters[randi() % disasters.size()]
		$weather_timer.wait_time = randi_range(60,90)
		$weather_timer.start()
		disaster_state = "heatwave"
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
			print("fog")
		elif disaster_state == "blizzard":
			print("blizzard")
		elif disaster_state == "heatwave":
			print("heatwave")
			
	else:
		fade_out()
		disaster_state = "none"
		Global.shake = "false"
		Global.fog = "false"
		$disaster_techs/lightning_tech/lightning_timer.stop()
		$weather_timer.wait_time = 10
		$weather_timer.start()


func _on_lightning_timer_timeout():
	thunder_strike()
	
func thunder_strike():
	var nextWaitTime = randi() % 15 + 5
	$disaster_techs/lightning_tech/thunderFlash.play("lightning")
	$disaster_techs/lightning_tech/lightning_timer.set_wait_time(nextWaitTime)
	$disaster_techs/lightning_tech/lightning_timer.start()

func fade_in():
	$disaster_techs/fog_tech/fog.self_modulate.a = 0.5
	
func fade_out():
	$disaster_techs/fog_tech/fog.modulate.a = 0.0

func hide_all():
	$disaster_techs/acid_rain_tech/acid_rain.visible = false
	$acid_tint.visible = false
	$disaster_techs/lightning_tech/storm_rain.visible = false
	$storm_tint.visible = false
	$disaster_techs/meteor_tech/meteor_storm.visible = false
	$meteor_tint.visible = false
	$disaster_techs/fog_tech/fog.visible = false
	$blizzard_tint.visible = false
	$disaster_techs/blizzard_tech/blizzard_storm.visible = false
	$heatwave_tint.visible = false
