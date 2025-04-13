extends Camera2D

@export var random_strength : float = 10.0
@export var shake_fade : float = 5.0

var rng = RandomNumberGenerator.new()

var shake_strength : float = 0.0

func apply_shake():
	shake_strength = random_strength

func remove_shake():
	shake_strength = 0

func _process(delta):
	if (Global.shake == "true"):
		apply_shake()
		offset = randomOffset()
	else:
		remove_shake()

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength,shake_strength),rng.randf_range(-shake_strength,shake_strength))
