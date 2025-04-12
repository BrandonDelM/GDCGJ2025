class_name main_panel extends Control

@export var money_value := 0
@onready var money_label: Label = $Panel/money_label
@onready var money_timer: Timer = $Panel/money_timer

func _ready() -> void:
	money_label.text = "$$$: " + str(money_value)
	print("Main menu is working!")
	


func _on_test_button_pressed_grant_money() -> void:
	money_value += 1
	money_label.text = "$$$: " + str(money_value)
