class_name PlayerState extends State

const IDLE = "Idle"
const RUNNING = "Running"
const JUMPING = "Jumping"
const FALLING = "Falling"
const DASHING = "Dashing"

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. 
			It needs the owner to be a Player node.")

func get_gravity() -> float:
	return player.jump_gravity if player.velocity.y < 0.0 else player.fall_gravity
	
func movement(acceleration, deceleration, direction, delta) -> void:
	if direction == 1:
		player.velocity.x = min(player.velocity.x + acceleration * delta, player.speed)
	elif direction == -1:
		player.velocity.x = max(player.velocity.x - acceleration * delta, -player.speed)
	else:
		if player.velocity.x > 0.0:
			player.velocity.x = max(player.velocity.x - deceleration * delta, 0.0)
		elif player.velocity.x < 0.0:
			player.velocity.x = min(player.velocity.x + deceleration * delta, 0.0)
	
func coyote_timeout():
	player.jump_available = false

func dash_timeout():
	player.dash_available = true
