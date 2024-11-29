extends PlayerState

var input_direction_x

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.y = 0
	player.dash_available = false
	player.dash_finished = false
	player.get_tree().create_timer(player.dash_time).timeout.connect(dash_timeout)
	if player.get_node("AnimatedSprite2D").flip_h:
		input_direction_x = -1
	else:
		input_direction_x = 1
	player.find_child("Label").text = "Dashing"
	player.find_child("AnimatedSprite2D").play("dash")

func physics_update(delta: float) -> void:
	if !player.dash_finished:
		player.velocity.x = player.dash_force * input_direction_x
		player.get_tree().create_timer(player.dash_cooldown).timeout.connect(dash_cooldown_timeout)
	
	player.move_and_slide()
	
	if player.is_on_floor():
		if player.dash_finished:
			finished.emit(RUNNING)
	elif player.dash_finished:
		finished.emit(FALLING)
