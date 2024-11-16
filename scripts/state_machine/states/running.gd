extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.find_child("Label").text = "Running"

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	movement(input_direction_x)
	player.velocity.y = player.snapping_force
	
	if input_direction_x == 1:
		player.find_child("AnimatedSprite2D").flip_h = false
	elif input_direction_x == -1:
		player.find_child("AnimatedSprite2D").flip_h = true
	
	player.find_child("AnimatedSprite2D").play("run")
	
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("move_up"):
		finished.emit(JUMPING)
	elif is_equal_approx(player.velocity.x, 0.0):
		finished.emit(IDLE)
