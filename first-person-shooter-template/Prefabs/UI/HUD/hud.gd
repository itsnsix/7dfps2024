extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# This adds the health text to the HUD by linking it to the global value
	add_child(Global.player_values.health_str)
	Global.player_values.health_str.set_position($HealthValue.position)
	Global.player_values.health_str.set_size($HealthValue.size)
	Global.player_values.health_str.add_theme_font_size_override('normal_font_size', 30)
	Global.player_values.emit_signal('player_injured', 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
