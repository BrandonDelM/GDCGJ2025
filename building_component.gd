class_name building
extends Panel

@export var MIN_COST : int
@export var MIN_AMOUNT : int
@export var MONEY_GEN : float

var building_cost : int
var building_amount : int
var building_generation : float

@onready var amount_text: Label = $amount_text
@onready var cost_text: Label = $cost_text


func _ready() -> void:
	building_cost = MIN_COST
	building_amount = MIN_AMOUNT
	building_generation = MONEY_GEN
	print("Building is working!")
	update()

func update():
	cost_text.text = "$" + str(building_cost)
	amount_text.text = str(building_amount)
	

func generate_money():
	if building_amount > 0:
		Global.money_value += building_generation * building_amount
	update()

func _on_building_buy_button_pressed() -> void:
	
	if Global.money_value >= building_cost:
		print("Building bought!")
		Global.money_value -= building_cost
		building_amount += 1
		building_cost *= 1.25
		update()

func _on_timer_timeout() -> void:
	generate_money()
