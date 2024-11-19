extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.jump_available = false
	player.jump_time_to_descent = 0.4
	player.velocity.y = player.jump_velocity
	player.find_child("Label").text = "Jumping"
		
func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	movement(player.air_acceleration, player.air_deceleration, input_direction_x, delta)

	player.velocity.y += get_gravity() * delta
	
	if input_direction_x == 1:
		player.find_child("AnimatedSprite2D").flip_h = false
	elif input_direction_x == -1:
		player.find_child("AnimatedSprite2D").flip_h = true
	
	player.find_child("AnimatedSprite2D").play("jump")

	if Input.is_action_just_released("move_up") and player.velocity.y < 0:
		player.velocity.y = 0
		#player.jump_time_to_descent = 0.1

	player.move_and_slide()

	if player.velocity.y >= 0:
		finished.emit(FALLING)
