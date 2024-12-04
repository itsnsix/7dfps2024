extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# This adds the health text to the HUD by linking it to the global value
	add_child(Global.player_values.health_str)
	Global.player_values.health_str.set_position($HealthArea/HealthValue.global_position)
	Global.player_values.health_str.set_size($HealthArea/HealthValue.size)
	Global.player_values.health_str.add_theme_font_size_override('normal_font_size', 34)
	Global.player_values._on_player_injured(0)

	add_child(Global.ammo)
	Global.ammo.set_position($WeaponArea/LoadedAmmo.global_position)
	Global.ammo.set_size($WeaponArea/LoadedAmmo.size)
	Global.ammo.add_theme_font_size_override('normal_font_size', 34)
	Global.ammo.bbcode_enabled = true

	add_child(Global.reserve_ammo)
	Global.reserve_ammo.set_position($WeaponArea/AvailableAmmo.global_position)
	Global.reserve_ammo.set_size($WeaponArea/AvailableAmmo.size)
	Global.reserve_ammo.add_theme_font_size_override('normal_font_size', 34)
