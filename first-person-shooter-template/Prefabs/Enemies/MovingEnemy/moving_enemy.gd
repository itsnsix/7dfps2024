extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D

const SPEED = 3
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	if Global.player_values.position:
		nav_agent.target_position = Global.player_values.position
		var current_location = global_transform.origin
		var next_location = nav_agent.get_next_path_position()
		var new_velocity = (next_location - current_location).normalized() * SPEED
		velocity = new_velocity
		move_and_slide()
