extends PlayerState

var input_direction_x

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.y = 0
	player.dash_available = false
	get_tree().create_timer(player.dash_time).timeout.connect(dash_timeout)
	input_direction_x = Input.get_axis("move_left", "move_right")

func physics_update(delta: float) -> void:
	player.velocity.x = player.dash_force * input_direction_x
	
	player.move_and_slide()
	
	if player.is_on_floor():
		if is_equal_approx(player.velocity.x, 0):
			finished.emit(IDLE)
		elif !player.dash_available:
			finished.emit(RUNNING)
	elif is_equal_approx(player.velocity.x, 0):
		finished.emit(FALLING)
