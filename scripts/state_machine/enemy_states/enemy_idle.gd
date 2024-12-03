extends EnemyState

func enter(previous_state_path : String, data := {}) -> void:
	enemy.velocity.x = 0.0
	enemy.find_child("AnimatedSprite2D").play("idle_" + enemy.type)
	enemy.find_child("Label").text = "Idle"

func physics_update(delta : float):
	enemy.velocity.y = 0
	enemy.move_and_slide()
	
	if !enemy.is_on_floor():
		finished.emit(FALLING)
	
