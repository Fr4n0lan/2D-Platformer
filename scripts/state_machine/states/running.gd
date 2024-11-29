extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.find_child("Label").text = "Running"
	player.jump_available = true

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = delta * player.speed * input_direction_x
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
		if player.jump_available:
			finished.emit(JUMPING)
		else:
			player.jump_buffer = true
			get_tree().create_timer(player.jump_buffer_time).timeout.connect(jump_buffer_timeout)
	elif player.jump_buffer:
		finished.emit(JUMPING)
	elif abs(player.velocity.x) < 100:
		finished.emit(IDLE)
	elif Input.is_action_just_pressed("dash") and player.dash_available:
		finished.emit(DASHING)
