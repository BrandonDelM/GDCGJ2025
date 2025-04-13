extends Node

@onready var ground = $Ground
@onready var preview = $Preview

var source_id : int
var selected_tile : Vector2i

var select_mode : bool = false
var preview_tile : Vector2i

func get_snapped_position(global_pos: Vector2) -> Vector2i:
	var local_pos = ground.to_local(global_pos)
	var tile_pos = ground.local_to_map(local_pos)
	
	return tile_pos

func _physics_process(delta):
	if select_mode:
		preview_tile = get_snapped_position(get_global_mouse_position())

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT and select_mode:
			place_tile(preview_tile)
			select_mode = false
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			ground.erase_cell(preview_tile)
	
	
	if event is InputEventKey:
		if event.keycode == KEY_1 and event.pressed:
			select_mode = true
			source_id = 0
			selected_tile = Vector2i(15,12)

func place_tile(tile_pos: Vector2i):
	ground.set_cell(tile_pos, source_id, selected_tile)
	preview.erase_cell(tile_pos)
