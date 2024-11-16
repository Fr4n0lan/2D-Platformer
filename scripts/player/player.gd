class_name Player extends CharacterBody2D

@export var speed := 2400.0
@export var gravity := 4800.0
@export var jump_impulse := 2300.0
@export var snapping_force := 5.0
@export var buffer_time := 0.2

var buffer_timer := 0.0
var jump_buffered = false
