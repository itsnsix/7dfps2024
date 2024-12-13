extends Projectile
@export var line_tex = Texture2D
@export var laser_mat : Material
var laserMesh : ImmediateMesh

func Fire_Projectile(_spread: Vector2 ,_range: int, _proj:PackedScene, origin_point: Vector3):
	var Camera_Collision = Camera_Ray_Cast(_spread,_range)
	
	match Projectile_Type:
		"Hitscan":
			Hit_Scan_Collision(Camera_Collision, damage,origin_point)
			instantiate_line(origin_point, Camera_Collision[1])
		"Rigidbody_Projectile":
			Launch_Rigid_Body_Projectile(Camera_Collision, _proj,origin_point)
		"over_ride":
			_over_ride_collision(Camera_Collision, damage)

func instantiate_line(start_point : Vector3, intersection_point : Vector3):
	#var laser : CSGCylinder3D = self.get_child(0)
	var mesh_instance : MeshInstance3D = MeshInstance3D.new()
	var laserPrim : CylinderMesh = CylinderMesh.new()
	
	laserPrim.height = start_point.distance_to(intersection_point)
	laserPrim.cap_top = true
	laserPrim.radial_segments = 16
	laserPrim.top_radius = 0.2;
	laserPrim.bottom_radius = 0.2;
	mesh_instance.global_position = (start_point + intersection_point) / 2
	laserPrim.material = laser_mat
	mesh_instance.mesh = laserPrim
	
	#laser.transform.looking_at(intersection_point, laser.basis.x)
	get_tree().root.add_child(mesh_instance)
	var laser_rotation = (intersection_point - start_point).normalized();
	var rotation_basis = Basis.looking_at(laser_rotation, Vector3.UP)
	mesh_instance.rotation = rotation_basis.get_euler()
	mesh_instance.rotate_object_local(Vector3.RIGHT, deg_to_rad(90))
	#laser.rotate
	
	#laser.global_rotation = laser_rotation
	
	#print(laser.get_parent_node_3d())
	#mesh_instance.mesh = newMesh
	
	#mesh_instance.
	#print(mesh_instance.name)
	#mesh_instance.global_position = (start_point + intersection_point) / 2
	
	#var anchor = Node3D.new()
	#var shape = CylinderShape3D.new()
	#anchor.add_child(shape)
	#shape.height = start_point.distance_to(intersection_point)
	#shape.radius = 0.2
	
	#anchor.global_position = (start_point + intersection_point) / 2
	#add_child(shape)
	#add_child(immediate_mesh)
