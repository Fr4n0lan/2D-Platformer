extends Camera2D

@export var random_strength := 60.0
@export var shake_fade := 7.0

var rng = RandomNumberGenerator.new()

var shake_strength := 0.0

var DashNode

func _ready() -> void:
	DashNode = get_parent().get_node("State Machine/Dashing")
	DashNode.dashed.connect(dash_shake)

func apply_shake() -> void:
	shake_strength = random_strength

func _process(delta: float) -> void:
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		
		offset = randomOffset()
		
func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
	
func dash_shake():
	apply_shake()
