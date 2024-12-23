#class_name EnemyBaseOld extends CharacterBody3D
#
#@onready var nav_agent = $NavigationAgent3D
#@onready var health_bar = $EnemyHealthBar/SubViewport/ProgressBar
#@onready var shoot_timer = $ShootTimer
#var xform : Transform3D
#
#var player_entered: bool = false
#var speed = 4
#var state = IDLE
#var fov = deg_to_rad(60)
#var accuracy_modifier = 0.5
#var damage = 1
#
#enum {
	#MENU,
	#ACTION,
	#LOADING,
	#IDLE,    # Not doing anything
	#WAKEUP,  # Just saw the player
	#SLEEP,   # Lost the player going back to sleep
	#PATROL,  # Moving around some predefined path
	#ALERT,   # Engaging the player
	#INJURED, # Stunned or has just taken damage
	#KILLED   # Dead
#}
#
#func _physics_process(delta: float) -> void:
	#
#
	#if state == KILLED:
		#queue_free()
		#
	#if player_in_range() and player_in_fov() and player_visible():
		#if state == IDLE:
			#state = WAKEUP
		#if state == ALERT:
			#target_player()
			#chase_player(delta)
			#if shoot_timer.is_stopped():
				#shoot_timer.start()
	#else:
		#if state == ALERT:
			#state = SLEEP
			#nav_agent.set_velocity(Vector3.ZERO)
			#shoot_timer.stop()
		#elif state == IDLE:
			#pass
	#
	#if not is_on_floor():
		#velocity += get_gravity() * delta
		#align_with_floor(Vector3.UP)
		#global_transform = global_transform.interpolate_with(xform, 0.3)
	#print(is_on_floor())
	#if is_on_floor():
		#align_with_floor($RayCast3D.get_collision_normal())
		#global_transform = global_transform.interpolate_with(xform, 0.3)
#
		#
#
#func idle_state():
	#nav_agent.set_velocity(Vector3.ZERO)
#
#func target_player():
	#$FaceDirection.look_at(Global.player_values.position, Vector3.UP)
	#rotate_y(deg_to_rad($FaceDirection.rotation.y) * 10.0)
#
#
#func chase_player(delta: float):
	#nav_agent.target_position = Global.player_values.position
	#var current_location = global_transform.origin
	#var next_location = nav_agent.get_next_path_position()
	#var new_velocity = (next_location - current_location).normalized() * speed
	#nav_agent.set_velocity(new_velocity)
#
#func player_visible() -> bool:
	#var player = get_tree().current_scene.get_node("player")
	#var state_space = get_world_3d().direct_space_state
	#var from = global_transform.origin + Vector3(0, 2, 0);
	#var to = player.global_transform.origin
	#var query = PhysicsRayQueryParameters3D.create(from, to)
	#query.exclude = [self]
	#var result = state_space.intersect_ray(query)
	#if result && result.collider.name == "player":
		#print('player visible %s' % name)
		#return true
	#print('player not visible %s' % name)
	#return false
#
#
#func player_in_fov():
	#var direction = global_position.direction_to(Global.player_values.position)
	#if global_transform.basis.tdotz(direction) < cos(fov):
		#print('%s player in fov' % name)
		#return true
	#print('%s player not in fov' % name)
	#return false
#
#
#func player_in_range():
	#var player = get_tree().current_scene.get_node("player")
	#if (global_transform.origin - player.global_transform.origin).length() < 10:
		#print('player in range')
		#return true
	#print('player not in range')
	#return false
#
#
#func shoot():
	#var player = get_tree().current_scene.get_node("player")
	#var state_space = get_world_3d().direct_space_state
	#var from = global_transform.origin + Vector3(0, 2, 0)
	#var to = player.global_transform.origin + Vector3(randf(), randf(), randf()) * accuracy_modifier
	#var query = PhysicsRayQueryParameters3D.create(from, to)
	#query.exclude = [self]
	#var result = state_space.intersect_ray(query)
	#if result && result.collider.name == "player":
		#Global.player_values._on_player_injured(damage)
#
#
#func Hit_Successful(_damage, Direction, Position):
	#print('%s im hit' % name)
	#health_bar.value -= _damage
	#if health_bar.value > 0:
		#state = INJURED
	#else:
		#state = KILLED
#
#
#func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	#velocity = safe_velocity
	#move_and_slide()
#
#
#func align_with_floor(floor_normal: Vector3):
	#
	#xform = global_transform
	#xform.basis.y = floor_normal
	#xform.basis.x = -xform.basis.z.cross(floor_normal)
	#xform.basis = xform.basis.orthonormalized()
#
#func _on_shoot_timer_timeout() -> void:
	#print('shooting')
	#shoot()
