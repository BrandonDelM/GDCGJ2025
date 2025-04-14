extends Node

var shake : String = "false"

var fog : String = "false"

var disaster : String = "none"
var notify : bool = false

var buildings = []

var money_value : float = 999999.0

var people_value : int = 0
			
var select_mode : bool = false
var source_id : int = 0
var selected_tile : Vector2i

var Dic = {}

var placeable = false

var erase : Vector2i
var erase_status = false

var tile_info = PackedVector2Array([])
