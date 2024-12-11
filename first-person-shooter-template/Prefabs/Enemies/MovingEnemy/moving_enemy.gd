class_name MovingEnemy extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var player_entered: bool = false
var speed = 2


func _physics_process(delta: float) -> void:

	if player_entered and check_player_in_view() and player_visible():
		target_player()
		chase_player(delta)
		shoot()
	else:
		idle_state()

func idle_state():
	nav_agent.set_velocity(Vector3.ZERO)

func target_player():
	$FaceDirection.look_at(Global.player_values.position, Vector3.UP)
	rotate_y(deg_to_rad($FaceDirection.rotation.y) * 10.0)


func chase_player(delta: float):
	nav_agent.target_position = Global.player_values.position
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * speed * delta
	nav_agent.set_velocity(new_velocity)

func player_visible() -> bool:
	var player = get_tree().current_scene.get_node("player")
	var state_space = get_world_3d().direct_space_state
	var from = global_transform.origin;
	var to = player.global_transform.origin
	var query = PhysicsRayQueryParameters3D.create(from, to)
	query.exclude = [self]
	var result = state_space.intersect_ray(query)
	if result && result.collider.name == "player":
		return true
	return false

func shoot():
	pass


func check_player_in_view():
	var direction = global_position.direction_to(Global.player_values.position)
	return global_transform.basis.tdotz(direction) < cos(deg_to_rad(60))


func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	move_and_collide(safe_velocity)


func _on_area_3d_body_entered(body: Node3D) -> void:
	player_entered = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	player_entered = false
