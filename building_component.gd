class_name building extends Panel

@export var MIN_COST : int
@export var MIN_AMOUNT : int
@export var MONEY_GEN : float
@export var PEOPLE_GEN : int
@export var BUILDING_NAME : String

var building_cost : int
var building_amount : int
var building_generation : float
var building_people_gen : int

@onready var amount_text: Label = $amount_text
@onready var cost_text: Label = $cost_text
@onready var buy_button: Button = $buy_button

func _ready() -> void:
	building_cost = MIN_COST
	building_amount = MIN_AMOUNT
	building_generation = MONEY_GEN
	building_people_gen = PEOPLE_GEN
	buy_button.text = BUILDING_NAME
	generate_people()
	update()

func update():
	cost_text.text = "$" + str(building_cost)
	amount_text.text = str(building_amount)
	

func generate_money():
	if building_amount > 0 and building_generation != 0:
		Global.money_value += building_generation * building_amount
	update()

func generate_people():
	if building_amount > 0:
		Global.people_value += building_people_gen
	update()

func _on_building_buy_button_pressed() -> void:
	if Global.money_value >= building_cost:
		if (BUILDING_NAME == "House"):
			Global.select_mode = true
			Global.source_id = 0
			Global.selected_tile = Vector2i(15,12)
		Global.money_value -= building_cost
		building_amount += 1
		building_cost *= 1.25
		generate_people()
		update()

func _on_timer_timeout() -> void:
	generate_money()
