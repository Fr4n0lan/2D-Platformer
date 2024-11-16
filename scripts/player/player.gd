class_name Player extends CharacterBody2D


@export var speed := 2400.0
@export var snapping_force := 5.0
@export var acceleration : float
@export var deceleration : float
@export var air_acceleration : float
@export var air_deceleration : float

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent: float

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak ** 2)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent ** 2)) * -1.0


@onready var buffer_timer = $BufferTimer
var jump_buffered = false
