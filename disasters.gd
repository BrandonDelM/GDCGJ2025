extends StaticBody2D

var disaster_state = "none"
const disasters = ["acid", "storm", "meteor", "earthquake"]
var disaster_time

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
	elif disaster_state == "earthquale":
		Global.shake = "true"


func _on_weather_timer_timeout():
	if disaster_state == "none":
		disaster_state = disasters[randi() % disasters.size()]
		disaster_time = randi_range(60,120)
		$weather_timer.wait_time = disaster_time
		$weather_timer.start()
		if disaster_state == "storm":
			print("thunder")
			thunder_strike()
		elif disaster_state == "acid":
			print("acid")
		elif disaster_state == "meteor":
			print("meteor")
		elif disaster_state == "earthquake":
			print("earthquake")
			
	else:
		disaster_state = "none"
		Global.shake = "false"
		$disaster_techs/lightning_tech/lightning_timer.stop()
		$weather_timer.wait_time = 10
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
