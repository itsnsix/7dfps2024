extends Node

#class_name GameManager
# Enumerate possible game states
enum GameState {
	MENU,
	PLAYING,
	LOADING
}

@export var all_scenes: Array[PackedScene] = [
	preload("res://Levels/BridgeRoom/BridgeRoom.tscn"),
	preload("res://Levels/HallwayRoom/HallwayRoom.tscn"),
	preload("res://Levels/HRoom/HRoom.tscn"),
	preload("res://Levels/SnakeyRoom/SnakeyRoom.tscn"),
	preload("res://Levels/SquareRoom/SquareRoom.tscn")
]
# Current game state
var current_state: GameState = GameState.MENU

var score : int = 0

# Signal to broadcast state changes
signal state_changed(new_state)

func _ready():
	# Set process input to true to enable key input detection
	set_process_input(true)

# Function to change the game state
func set_state(new_state : String):
	var ns :GameState
	match new_state:
		"MENU":
			ns = GameState.MENU
		"PLAYING":
			ns = GameState.PLAYING
		"LOADING":
			ns = GameState.LOADING
		_:
			push_error("bruh aint no way you typed ts ahh blud: " + new_state)
	# Only change if the state is different
	if ns != current_state:
		current_state = ns
		# Broadcast the new state via signal
		emit_signal("state_changed", current_state)
		
		# Debug log of current state
		print("Game state changed to: ", GameState.keys()[current_state])

# Input handling for state changes
func _input(event):
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_7:
				set_state("MENU")
			KEY_8:
				set_state("PLAYING")
			KEY_9:
				set_state("LOADING")

func change_scene():
	var rand_int = randi() % all_scenes.size()
	# Don't load the same room because that's boring
	while all_scenes[rand_int].resource_path == get_parent().scene_file_path:
		rand_int = randi() % all_scenes.size()
	# Load the next room
	get_tree().change_scene_to_packed(all_scenes[rand_int])

#Helper Functions
func get_score() -> int:
	return score

func is_current_state(state: GameState) -> bool:
	return current_state == state

# Optional debug function
func get_current_state_name() -> String:
	return GameState.keys()[current_state]
