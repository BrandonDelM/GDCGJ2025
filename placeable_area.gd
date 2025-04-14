extends TileMap

func _ready():
	for x in range(26, 46):
		for y in range(10, 30):
			if (x != 45 and y != 10 and y != 29):
				Global.Dic[str(Vector2i(x,y))] = {
				"Type": "placeable"
				}
			set_cell(0, Vector2i(x,y), 0, Vector2i(2, 15))

func _process(delta):
	var location = local_to_map(get_global_mouse_position())
	if (Global.Dic.has(str(location)) == false):
		Global.placeable = false
	else:
		Global.placeable = true
