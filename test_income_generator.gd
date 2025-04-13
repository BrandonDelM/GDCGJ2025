class_name main_panel extends Control

@onready var money_label: Label = $Panel/money_label
@onready var money_timer: Timer = $Panel/money_timer

func _ready() -> void:
	update_labels()
	print("Main menu is working!")

func _process(delta) -> void:
	update_labels()

func update_labels():
	money_label.text = "$$$: " + str(Global.money_value)

func _on_test_button_pressed_grant_money() -> void:
	Global.money_value += 1
	update_labels()
