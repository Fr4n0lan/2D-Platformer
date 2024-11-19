extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	if player.jump_available:
		get_tree().create_timer(player.coyote_time).timeout.connect(coyote_timeout)
	player.find_child("Label").text = "Falling"

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	movement(player.air_acceleration, player.air_deceleration, input_direction_x, delta)

	player.velocity.y += get_gravity() * delta
	
	if input_direction_x == 1:
		player.find_child("AnimatedSprite2D").flip_h = false
	elif input_direction_x == -1:
		player.find_child("AnimatedSprite2D").flip_h = true
	
	player.find_child("AnimatedSprite2D").play("jump")
	
	player.move_and_slide()

	if player.is_on_floor():
		if abs(player.velocity.x) < 100:
			finished.emit(IDLE)
		else:
			finished.emit(RUNNING)
	elif Input.is_action_pressed("move_up") and player.jump_available:
		finished.emit(JUMPING)
