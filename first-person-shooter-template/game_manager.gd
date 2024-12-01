extends Node

# Enumerate possible game states
enum GameState {
	MENU,
	ACTION,
	LOADING
}

# Current game state
var current_state: GameState = GameState.MENU

# Signal to broadcast state changes
signal state_changed(new_state)

func _ready():
	# Set process input to true to enable key input detection
	set_process_input(true)

# Function to change the game state
func change_state(new_state : GameState):
	# Only change if the state is different
	if new_state != current_state:
		current_state = new_state
		# Broadcast the new state via signal
		emit_signal("state_changed", current_state)
		
		# Debug log of current state
		print("Game state changed to: ", GameState.keys()[current_state])

# Input handling for state changes
func _input(event):
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_7:
				change_state(GameState.MENU)
			KEY_8:
				change_state(GameState.ACTION)
			KEY_9:
				change_state(GameState.LOADING)

# Optional helper functions
func is_current_state(state: GameState) -> bool:
	return current_state == state

# Optional debug function
func get_current_state_name() -> String:
	return GameState.keys()[current_state]
