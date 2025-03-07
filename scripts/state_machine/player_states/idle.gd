extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.x = 0.0
	player.jump_available = true
	player.find_child("AnimatedSprite2D").play("idle")
	player.find_child("Label").text = "Idle"

func physics_update(delta: float) -> void:
	player.velocity.y = player.snapping_force
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
		print("jump_buffered")
	elif Input.is_action_just_pressed("dash") and player.dash_available:
		finished.emit(DASHING)
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		finished.emit(RUNNING)
