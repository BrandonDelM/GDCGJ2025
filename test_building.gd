extends Panel

@export var MIN_COST := 10
@export var MIN_BUILDINGS := 0
@export var MONEY_GENERATION := 1

var building_cost : int
var building_amount : int
var building_generation : int

@onready var building_amount_text: Label = $building_amount_text
@onready var building_cost_text: Label = $building_cost_text

func _ready() -> void:
	print("Building is working!")
	building_cost = MIN_COST
	building_amount = MIN_BUILDINGS
	building_generation = MONEY_GENERATION
	
	building_cost_text.text = "$" + str(building_cost)
	building_amount_text.text = str(building_amount)



#func generate_money():
	#$resources_menu.money_value += building_money_generation * building_amount_value
	#print("Generation is working")
	#
#
#func _on_building_buy_button_pressed() -> void:
	#print("Processing building")
	#if $resources_menu.money_value >= building_cost_value:
		#print("Building bought!")
		#$resources_menu.money_value -= building_cost_value
		#building_amount_value += 1
		#building_amount_value.text = str(building_amount_value)
	#else:
		#print("Building not bought")
