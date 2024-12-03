extends EnemyState

func enter(previous_state_path : String, data := {}) -> void:
	enemy.find_child("Label").text = "Falling"

func physics_update(delta : float):
	enemy.velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	enemy.move_and_slide()
	
	if enemy.is_on_floor():
		finished.emit(IDLE)
	
