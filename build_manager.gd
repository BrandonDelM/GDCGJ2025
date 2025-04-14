extends Node2D

var used_tiles = []

#Gets every tile an object that the layer is covering and more
func get_tiles(layer : TileMapLayer, selected_tile : Vector2i, tile_pos : Vector2i):
	var source_id = layer.get_cell_source_id(tile_pos)
	var atlas_tile : TileSetAtlasSource
	var tile_size
	
	if source_id != -1:
		atlas_tile = layer.tile_set.get_source(source_id)
	if atlas_tile:
		tile_size = atlas_tile.get_tile_size_in_atlas(selected_tile)
		print(tile_size)
	
	for j in range(tile_size.y):
		for i in range(tile_size.x):
			var tile = tile_pos + Vector2i(i,j)
			if tile not in used_tiles:
				used_tiles.append(tile)
