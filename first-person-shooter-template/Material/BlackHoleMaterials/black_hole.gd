extends RigidBody3D
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var captured_bodies: Array[RigidBody3D]
var captured_parents: Array
var captured_body_names: Array[String]
var gravity_start = false


func _ready() -> void:
	$FreezeTimer.wait_time = 1
	$FreezeTimer.start()
	$DeleteTimer.wait_time = 5
	$DeleteTimer.start()
	
func _physics_process(delta: float) -> void:
	pass
	#if $FreezeTimer.is_stopped():
		#$FreezeTimer.wait_time = abs(linear_velocity.y) / abs(gravity)
		#$FreezeTimer.start()
	#for body in captured_bodies:
		#print(body.name)
		#body.velocity.y += 50

func _on_freeze_timer_timeout() -> void:
	linear_velocity = Vector3.ZERO
	gravity_scale = 0
	gravity_start = true


func _on_delete_timer_timeout() -> void:
	$DeleteAnimation.play("disappear")


func _on_delete_animation_animation_finished(anim_name: StringName) -> void:
	for i in range(captured_bodies.size()):
		captured_bodies[i].gravity_scale = 1.0
		var child = captured_bodies[i].get_child(0)
		print(child.name)
		print(captured_bodies[i].name)
		
	queue_free()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D and body.name not in captured_body_names:
		captured_body_names.append(body.name)
		print("%s entered" % body.name)
		var rigid_body = RigidBody3D.new()
		var collision_shape = CollisionShape3D.new()
		collision_shape.shape = BoxShape3D.new()
		rigid_body.add_child(collision_shape)
		rigid_body.gravity_scale = -0.1
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
	#if body.name in captured_body_names:
		#print("%s exited" % body.name)
		#body.reparent(get_tree().current_scene)
