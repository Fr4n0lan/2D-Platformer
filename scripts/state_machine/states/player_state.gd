class_name PlayerState extends State

const IDLE = "Idle"
const RUNNING = "Running"
const JUMPING = "Jumping"
const FALLING = "Falling"

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. 
			It needs the owner to be a Player node.")

func get_gravity() -> float:
	return player.jump_gravity if player.velocity.y < 0.0 else player.fall_gravity
	
func movement(direction) -> void:
	if direction == 1:
		player.velocity.x = min(player.velocity.x + player.acceleration, player.speed)
	elif direction == -1:
		player.velocity.x = max(player.velocity.x - player.deceleration, -player.speed)
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, 0.2)
		
	player.velocity.x = clamp(player.velocity.x, -player.speed, player.speed)

func air_movement(direction) -> void:
	if direction == 1:
		player.velocity.x += player.air_acceleration
	elif direction == -1:
		player.velocity.x -= player.air_deceleration
		
	player.velocity.x = clamp(player.velocity.x, -player.speed, player.speed)
