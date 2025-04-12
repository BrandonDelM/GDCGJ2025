extends StaticBody2D

var disaster_state = "none"

# Called when the node enters the scene tree for the first time.
func _ready():
	if disaster_state == "none":
		
		$Node2D/acid_rain.visible = false
		$Node2D/weather_tint.visible = false
	else:
		$Node2D/acid_rain.visible = true
		$Node2D/weather_tint.visible = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if disaster_state == "none":
		$Node2D/acid_rain.visible = false
		$Node2D/weather_tint.visible = false
	else: 
		$Node2D/acid_rain.visible = true
		$Node2D/weather_tint.visible = true


func _on_weather_timer_timeout():
	if disaster_state == "none":
		disaster_state = "rain"
		$Node2D/weather_timer.wait_time = randi_range(10,30)
		$Node2D/weather_timer.start()
	elif disaster_state == "rain":
		disaster_state = "none"
		$Node2D/weather_timer.wait_time = randi_range(30, 120)
		$Node2D/weather_timer.start()
	
