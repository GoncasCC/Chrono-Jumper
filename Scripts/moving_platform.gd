extends StaticBody2D

@export var move_speed: float = 100.0 # How fast the platform moves (in pixels per second)
@export var move_range: float = 200.0 # The vertical range the platform will move up and down (in pixels)

var original_position: Vector2
var direction: int = 1 # 1 = moving up, -1 = moving down

func _ready():
	# Store the original position of the platform
	original_position = position

func _process(delta):
	# Move the platform vertically
	position.y += move_speed * direction * delta

	# If it moves beyond the set range, reverse direction
	if position.y > original_position.y + move_range:
		direction = -1
	elif position.y < original_position.y - move_range:
		direction = 1
