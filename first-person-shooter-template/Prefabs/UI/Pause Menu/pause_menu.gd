extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_game_state_changed():
	if(GameManager.get_current_state_name() == "MENU"):
		get_child(0).visible = true
	else:
		#DIE
		get_child(0).visible = false
	pass
