class_name Player extends CharacterBody2D

#Speed Variables
@export var speed := 90000
@export var snapping_force := 5.0
@export var acceleration := 6000
@export var deceleration := 50000
@export var air_acceleration := 3000
@export var air_deceleration := 6000

#Dash Variables
@export var dash_force := 6000
var dash_available := true
@export var dash_cooldown := 0.6
@export var dash_time := 0.6

#Jump Variables
@export var jump_height := 900
@export var jump_time_to_peak := 0.6
@export var jump_time_to_descent := 0.4

#Jump Calculation Variables
@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak ** 2)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent ** 2)) * -1.0

#Coyote Time Variables
@export var coyote_time := 0.2
@onready var jump_available := true
