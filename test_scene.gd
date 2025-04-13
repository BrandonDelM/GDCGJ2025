extends Node2D

@onready var ground = $Ground
@onready var preview = $Preview

var source_id : int
var selected_tile : Vector2i

var select_mode : bool = false
var preview_tile : Vector2i:
	set(value):
		if preview_tile == value:
			return
		
		preview.erase_cell(0, preview_tile)
		preview_tile = value
		preview.set_cell(0, value, source_id, selected_tile)
		
		var atlas_tile : TileSetAtlasSource
		atlas_tile = preview.tile_set.get_source(source_id)
		var tile_size
		if atlas_tile:
			tile_size = atlas_tile.get_tile_size_in_atlas(selected_tile)
		placeable = true
		for i in range(tile_size.y):
			for j in range(tile_size.x):
				var tile = preview_tile + Vector2i(i,j)
				if tile in BuildManager.used_tiles:
					placeable = false

var placeable : bool = true:
	set(value):
		placeable = value
		
		if value == false:
			preview.modulate = Color.RED
		else:
			preview.modulate = Color("ffffff6f")

func get_snapped_position(global_pos: Vector2) -> Vector2i:
	var local_pos = ground.to_local(global_pos)
	var tile_pos = ground.local_to_map(local_pos)
	
	return tile_pos

func _physics_process(delta):
	if select_mode:
		preview_tile = get_snapped_position(get_global_mouse_position())

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT and select_mode and placeable:
			place_tile(preview_tile)
			select_mode = false
		elif event.button_index == MOUSE_BUTTON_RIGHT:
				ground.erase_cell(0, preview_tile)
	
	if event is InputEventKey:
		if event.keycode == KEY_1 and event.pressed:
			select_mode = true
			source_id = 0
			selected_tile = Vector2i(15,12)
func place_tile(tile_pos : Vector2i):
	ground.set_cell(0, tile_pos, source_id, selected_tile)
	preview.erase_cell(0, tile_pos)
	BuildManager.get_tiles(ground, selected_tile, preview_tile)
