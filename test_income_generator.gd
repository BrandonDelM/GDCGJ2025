class_name main_panel extends Control

@onready var money_label: Label = $Panel/money_label
@onready var people_label: Label = $Panel/people_label

func _ready() -> void:
	update_labels()
	print("Main menu is working!")

func people_gen_money() -> void:
	Global.money_value += Global.people_value
	update_labels()

func update_labels():
	money_label.text = "$$$: " + str(Global.money_value)
	people_label.text = "People: " + str(Global.people_value)

func _on_test_button_pressed_grant_money() -> void:
	Global.money_value += 1
	update_labels()

func _on_timer_timeout() -> void:
	people_gen_money()
