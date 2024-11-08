extends CharacterBody2D

# Movement variables
@export var speed = 200.0   # Horizontal speed
@export var jump_force = -350.0  # Jump force (negative for upward movement)
@export var gravity = 1000.0   # Gravity force for all time periods (can be adjusted later)


# Control inputs
var is_jumping = false
# Player states
var on_ground = false


# Time Manipulation Variables
@export var pause_duration = 1.5  # Duration of the pause effect in seconds
@export var rewind_duration = 2.0  # Duration of the rewind effect in seconds
@export var fast_forward_duration = 1.5  # Duration of the fast forward effect in seconds
@export var cooldown_time = 5.0  # Cooldown time for each ability

# State tracking
var is_paused = false
var is_rewinding = false
var is_fast_forwarding = false
# Access Timer nodes
var pause_timer
var rewind_timer
var fast_forward_timer



func _ready():
	pause_timer = $PauseTimer
	rewind_timer = $RewindTimer
	fast_forward_timer = $FastForwardTimer


func _process(delta):
	# Handle player movement input
	velocity.x = 0.0  # Reset horizontal velocity each frame

	# Left and Right movement input (mapped to "ui_left" and "ui_right" by default)
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed

	# Jumping (mapped to "ui_up" by default)
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_force
		is_jumping = true

	# Apply gravity
	velocity.y += gravity * delta

	# Move the player with collision detection
	move_and_slide()

	# Check if the player has landed
	if is_on_floor() and is_jumping:
		is_jumping = false
