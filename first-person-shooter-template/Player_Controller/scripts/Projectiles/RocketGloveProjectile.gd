class_name RocketGloveProjectile extends Projectile

@onready var player: CharacterBody3D = get_tree().current_scene.get_node('player')


func _init() -> void:
	Projectile_Type = 'over_ride'

func _over_ride_collision(_camera_collision:Array, _damage: float) -> void:
	if not player.is_rocket_boosting:
		$Area3D.global_transform.origin = player.global_transform.origin + Vector3(0, .5, 0)
		player.is_rocket_boosting = true
		$BoostTime.start()
		player.velocity += player.find_child('MainCamera',).global_transform.basis * Vector3(0, 0, -1) * 100

func _on_boost_time_timeout() -> void:
	player.is_rocket_boosting = false
	pass # Replace with function body.


func _on_area_3d_body_entered(body: Node3D) -> void:
	print(body.name)
	if not player.is_rocket_boosting:
		return
	player.is_rocket_boosting = false
	player.velocity = Vector3.ZERO
	if body.is_in_group('Target') or body.is_in_group('Enemies'):
		if body.has_method('Hit_Successful'):
			body.Hit_Successful(50, Vector3.ZERO, Vector3.ZERO)
	else:
		Global.player_values._on_player_injured(50)
	pass # Replace with function body.
