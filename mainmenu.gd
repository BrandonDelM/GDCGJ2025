extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$title_music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	$title_music.stop()
	get_tree().change_scene_to_file("res://GameScreen.tscn")
	pass


func _on_options_menu_pressed():
	get_tree().change_scene_to_file("res://options.tscn")
	pass


func _on_credits_menu_pressed():
	get_tree().change_scene_to_file("res://creditsmenu.tscn")
	pass


func _on_quit_button_pressed():
	get_tree().quit()
