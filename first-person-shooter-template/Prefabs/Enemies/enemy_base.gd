class_name EnemyBase extends CharacterBody3D

enum EnemyStates {
	MENU,
	ACTION,
	LOADING,
	IDLE,
	PATROL,
	ALERT,
	INJURED,
	KILLED
}

@onready var nav_agent = $NavigationAgent3D
var fov: float = deg_to_rad(60)
var state: int = EnemyStates.IDLE
var player_near: bool = false
var health: int = 100
var speed: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta: float) -> void:
	if player_near and player_in_fov() and player_visible():
		print('ALERT')
		state = EnemyStates.ALERT
	else:
		print('IDLE')
		state = EnemyStates.IDLE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func player_in_fov():
	var direction = global_position.direction_to(Global.player_values.position)
	return global_transform.basis.tdotz(direction) < cos(fov)


func player_visible() -> bool:
	var player = get_tree().current_scene.get_node("player")
	var state_space = get_world_3d().direct_space_state
	var from = global_transform.origin + Vector3(0, 2, 0);
	var to = player.global_transform.origin
	var query = PhysicsRayQueryParameters3D.create(from, to)
	query.exclude = [self]
	var result = state_space.intersect_ray(query)
	if result:
		print(result.collider.name)
	if result && result.collider.name == "player":
		print("player visible")
		return true
	print("player not visible")
	return false


func target_player():
	$FaceDirection.look_at(Global.player_values.position, Vector3.UP)
	rotate_y(deg_to_rad($FaceDirection.rotation.y) * 10.0)


func chase_player(delta: float):
	nav_agent.target_position = Global.player_values.position
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * speed * delta
	nav_agent.set_velocity(new_velocity)
	
func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	move_and_collide(safe_velocity)


func Hit_Successful(_damage, Direction, Position):
	print('im hit')
	health -= _damage
	state = EnemyStates.INJURED


func _on_fov_body_entered(body: Node3D) -> void:
	print("player near")
	player_near = true


func _on_fov_body_exited(body: Node3D) -> void:
	print("player not near")
	player_near = false
