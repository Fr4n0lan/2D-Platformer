class_name EnemyState extends State

const IDLE = "Idle"
const CHASE = "Chase"
const FALLING = "Falling"

var enemy = Enemy

func _ready() -> void:
	await owner.ready
	enemy = owner as Enemy
	if enemy.type == "green":
		enemy.find_child("CollisionShape2D_green").disabled = false
		enemy.find_child("CollisionShape2D_orange").disabled = true
	elif enemy.type == "orange":
		enemy.find_child("CollisionShape2D_green").disabled = true
		enemy.find_child("CollisionShape2D_orange").disabled = false
	assert(enemy != null, "The EnemyState state type must be used only in the enemy scene. 
			It needs the owner to be a Enemy node.")
