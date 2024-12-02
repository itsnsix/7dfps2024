extends Area3D

# Emitted when the player enters the Area3D
signal entered_door(door: Node3D)
# Emitted when the player exits the Area3D
signal exited_door(door: Node3D)

# Boolean to indicate this is a spawn point. All doors start as exit doors
var is_spawn: bool = false

func _process(delta: float) -> void:
	pass

# Function is called when a body entere the Area3D
func _on_body_entered(body: Node3D) -> void:
	# Do not emit the "entered_door" signal if this is the spawn door
	if !is_spawn:
		# Emit the signal to the Player node which toggles the "near_door" variable
		emit_signal("entered_door", self)
		print(name)

# Function is called when the body exits the Area3D
func _on_body_exited(body: Node3D) -> void:
	# Do not emit the "exited_door" signal if this is the spawn door
	if !is_spawn:
		# Emit the signal to the Player node which toggles the "near_door" variable
		emit_signal("exited_door", self)
		print(name)
	
