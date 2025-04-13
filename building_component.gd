class_name buildingcomponent
extends Panel

@export var MIN_COST := 10
@export var MIN_BUILDINGS := 0
@export var MONEY_GENERATION := 0.1

var building_cost : int
var building_amount : int
var building_generation : float

@onready var amount_text: Label = $amount_text
@onready var cost_text: Label = $cost_text


func _ready() -> void:
	print("Building is working!")
	building_cost = MIN_COST
	building_amount = MIN_BUILDINGS
	building_generation = MONEY_GENERATION
	update_labels()

func update_labels():
	cost_text.text = "$" + str(building_cost)
	amount_text.text = str(building_amount)

func generate_money():
	if building_amount > 0:
		Global.money_value += building_generation * building_amount
		print("Generating money!")
	else:
		print("Not generating money :(")
	update_labels()

func _on_building_buy_button_pressed() -> void:
	print("Processing building")
	if Global.money_value >= building_cost:
		print("Building bought!")
		Global.money_value -= building_cost
		building_amount += 1
		building_cost *= 1.1
		update_labels()
	else:
		print("Building not bought")


func _on_timer_timeout() -> void:
	generate_money()
