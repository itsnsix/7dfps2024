extends Area3D

# Signal emitted when the door is opened
signal open_door(door : Node3D)

enum DoorType {
	SPAWN,
	EXIT
}
# Boolean to indicate this is a spawn point
@export var door_type: DoorType = DoorType.EXIT

# Input action for interaction
@export var interact_action: String = "interact"

func _ready() -> void:
	validate_single_spawn()
	pass
	
func validate_single_spawn() -> bool:
	# Iterate over all nodes in the scene tree to find all DoorArea nodes
	var spawn_count = 0
	for node in get_tree().get_nodes_in_group("doors"):
		if node.get_script() == get_script() and node.door_type == DoorType.SPAWN:
			spawn_count += 1
	if spawn_count > 1:
		push_error("YOU HAVE TOO MANY SPAWNS RETARD. KILL YOURSELF!!!!!!")
		return false
	return true

func _process(delta: float) -> void:
	# Check if the player is in the area and presses the interact button
		if Input.is_action_just_pressed(interact_action):
		# Check for player inside the area
			for body in get_overlapping_bodies():
				if body.get_script().get_global_name() == "player_character.gd":  # Ensure "Player" matches the player node's name
					# Emit the signal with the position of this Area3D
					# If this is a spawn point, optionally log or trigger additional logic
					match(door_type):
						DoorType.SPAWN:
							push_warning("Tried to open Spawn door!")
						DoorType.EXIT:
							print("Opening door at: ", global_position)
							emit_signal("open_door", self)
