extends Control



func _ready():
	GameManager.connect('state_changed', self._on_game_state_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_game_state_changed(new_state : String):
	print("mustard on the pipo!")
	if(new_state == "MENU"):
		get_child(0).visible = true
		print("mustard on the beat yo!")
	else:
		#DIE
		get_child(0).visible = false
	pass
