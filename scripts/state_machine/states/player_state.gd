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

func jump_buffering(delta) -> void:
	if player.is_on_floor():
		print("Jumped on the floor")
		finished.emit(JUMPING)
	elif not player.is_on_floor():
		print("Starting Jump Buffering")
		player.jump_buffered = true
		player.buffer_timer = player.buffer_time
		
	if player.jump_buffered:
		player.buffer_timer -= delta
		if player.buffer_timer <= 0.0:
			player.jump_buffered = false 
			
	if player.jump_buffered and player.is_on_floor():
		print("Jump buffered")
		finished.emit(JUMPING)
		player.jump_buffered = false
