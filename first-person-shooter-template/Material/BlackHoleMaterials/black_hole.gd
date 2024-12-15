extends RigidBody3D
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var captured_bodies: Array[RigidBody3D]
var captured_parents: Array
var captured_body_names: Array[String]
var gravity_start = false

# standard gravitational parameter
const MU = 10


func _ready() -> void:
	print(get_parent())
	$FreezeTimer.wait_time = 1
	$FreezeTimer.start()
	$DeleteTimer.wait_time = 5
	$DeleteTimer.start()
	
func _physics_process(delta: float) -> void:
	for body in captured_bodies:
		var r = body.global_transform.origin.direction_to(global_transform.origin)
		var f = MU * r / r.length_squared()
		body.apply_central_force(f)
			
		

func _on_freeze_timer_timeout() -> void:
	linear_velocity = Vector3.ZERO
	gravity_scale = 0


func _on_delete_timer_timeout() -> void:
	$DeleteAnimation.play("disappear")


func _on_delete_animation_animation_finished(anim_name: StringName) -> void:
	for i in range(captured_bodies.size()):
		captured_bodies[i].gravity_scale = 1.0
		captured_bodies[i].black_hole_disappeared = true
		#captured_bodies[i].get_child(1).reparent(captured_parents[i])
		
	queue_free()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.get_parent() is RigidBody3D:
		return

	if body is CharacterBody3D and body.name not in captured_body_names:
		captured_body_names.append(body.name)
		var rigid_body = CapturedBody.new()
		var collision_shape = CollisionShape3D.new()
		collision_shape.shape = BoxShape3D.new()
		rigid_body.add_child(collision_shape)
		rigid_body.gravity_scale = -0.1
		rigid_body.contact_monitor = true
		rigid_body.max_contacts_reported = 3
		
		var world = get_tree().current_scene
		world.add_child(rigid_body)
		rigid_body.name = body.name + "_container"
		rigid_body.global_position = body.global_position
		captured_parents.append(body.get_parent())
		body.reparent(rigid_body)
		rigid_body.apply_central_force(Vector3.UP * 100)
		captured_bodies.append(rigid_body)


func _on_area_3d_body_exited(body: Node3D) -> void:
	pass
