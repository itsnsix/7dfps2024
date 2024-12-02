extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get every door in the scene
	var doors = get_tree().get_nodes_in_group('Doors')
	# Pick a random number between 0 and the number of doors in the scene
	var rand_int = randi() % doors.size()
	# Choose 1 door to be the spawn
	var spawn_door = doors[rand_int]
	spawn_door.is_spawn = true
	
	# Preload the player scene (supposed to be faster than load)
	var player = preload("res://Player_Controller/player_character.tscn").instantiate()
	# Add the player to the root of the scene (wait until the root is ready)
	add_child(player)
	# Set the player's position to the spawn point position
	player.global_position = spawn_door.get_node('SpawnPoint').global_position
	# Set the player's camera as the current camera
	player.get_node("Camera/LeanPivot/MainCamera").make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
