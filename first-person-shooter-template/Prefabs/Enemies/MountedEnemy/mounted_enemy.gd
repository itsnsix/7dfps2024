extends CharacterBody3D

@onready var player_entered: bool = false

func _physics_process(delta: float) -> void:

	if player_entered and check_player_in_view():
		target_player()
		shoot()
	else:
		idle()


func idle():
	pass


func target_player():
	$FaceDirection.look_at(Global.player_values.position, Vector3.UP) 
	rotate_y(deg_to_rad($FaceDirection.rotation.y) * 10.0)


func shoot():
	pass


func check_player_in_view():
	var direction = global_position.direction_to(Global.player_values.position)
	return global_transform.basis.tdotz(direction) < cos(deg_to_rad(60))


func _on_area_3d_body_entered(body: Node3D) -> void:
	print(body.name)
	player_entered = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	player_entered = false
