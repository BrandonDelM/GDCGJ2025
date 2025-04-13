extends StaticBody2D

var disaster_state = "none"
const disasters = ["acid", "storm", "meteor", "earthquake", "fog", "blizzard", "heatwave"]

@export var side_label_node : PackedScene = preload("res://side_label.tscn")

@onready var noti_ui = $notify_tech/noti_ui

# Called when the node enters the scene tree for the first time.
func _ready():
	$title_music.play()
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
	$title_music.stop()
	if disaster_state == "none":
		disaster_state = disasters[randi() % disasters.size()]
		show_side(disaster_state)
		var time : int = randi_range(60,90)
		$weather_timer.wait_time = time
		$weather_timer.start()
		$destroy_timer.wait_time = randi_range(0, time)
		$destroy_timer.start()
		disaster_state = "heatwave"
		if disaster_state == "storm":
			$blizzard_audio.play()
			print("thunder")
			thunder_strike()
		elif disaster_state == "acid":
			$acid_audio.play()
			print("acid")
		elif disaster_state == "meteor":
			$meteor_audio.play()
			print("meteor")
		elif disaster_state == "earthquake":
			$earthquake_audio.play()
			print("earthquake")
		elif disaster_state == "fog":
			$fog_audio.play()
			print("fog")
		elif disaster_state == "blizzard":
			$blizzard.play()
			print("blizzard")
		elif disaster_state == "heatwave":
			print("heatwave")
	else:
		fade_out()
		$blizzard_audio.stop()
		$acid_audio.stop()
		$fog_audio.stop()
		$earthquake_audio.stop()
		$meteor_audio.stop()
		$storm_audio.stop()
		$title_music.play()
		disaster_state = "none"
		Global.shake = "false"
		Global.fog = "false"
		$disaster_techs/lightning_tech/lightning_timer.stop()
		$weather_timer.wait_time = randi_range(60, 120)
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
	$disaster_techs/fog_tech/fog.self_modulate.a = 0.0

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

func show_side(message):
	var side_label : Label = side_label_node.instantiate()
	side_label.text = "A " + message + " has arrived!"
	noti_ui.add_child(side_label)
	
	var tween : Tween = side_label.create_tween()
	tween.tween_interval(2.5)
	tween.tween_callback(side_label.queue_free)
	
func destroy_message(message):
	var side_label : Label = side_label_node.instantiate()
	side_label.text = message
	noti_ui.add_child(side_label)
	
	var tween : Tween = side_label.create_tween()
	tween.tween_interval(2.5)
	tween.tween_callback(side_label.queue_free)

func _on_destroy_timer_timeout() -> void:
	$destroy_timer.wait_time = randi_range(5, 20)
	$destroy_timer.start()
	if (disaster_state == "meteor"):
		var x = randi_range(0, 19)
		var y = randi_range(0, 19)
		for i in range(x, x+1):
			for j in range(y, y+1):
				print("Test")
	elif (disaster_state == "fog"):
		destroy_message("A human has died...");
		Global.people_value = Global.people_value - 1
	elif (disaster_state == "heatwave"):
		destroy_message("A human has died...");
		Global.people_value = Global.people_value - 1
	elif (disaster_state == "acid"):
		destroy_message("A human has died...");
		Global.people_value = Global.people_value - 1
		if (Global.buildings.size() != 0):
			var destroy = randi_range(0, Global.buildings.size()-1)
			Global.buildings.remove_at(destroy)
			destroy_message("A building has been destroyed!");
	elif (disaster_state == "blizard"):
		destroy_message("A human has died...");
		Global.people_value = Global.people_value - 1
		print("Destroy a building")
	elif (disaster_state == "earthquake"):
		print("Destroy a building")
	elif (disaster_state == "storm"):
		if (Global.buildings.size() != 0):
			var destroy = randi_range(0, Global.buildings.size()-1)
			var tile : Vector2i = Global.buildings[destroy-1]
			Global.buildings.remove_at(destroy)
			destroy_message("A building has been destroyed!");
