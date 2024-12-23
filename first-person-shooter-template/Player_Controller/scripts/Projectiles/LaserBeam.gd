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
	var collider : StaticBody3D = StaticBody3D.new()
	var collision_shape : CollisionShape3D = CollisionShape3D.new()
	var cyl_shape : CylinderShape3D = CylinderShape3D.new()
	var timer : Timer = Timer.new()
	timer.start(10)
	
	mesh_instance.create_trimesh_collision()
	laserPrim.height = start_point.distance_to(intersection_point)
	laserPrim.cap_top = true
	laserPrim.radial_segments = 16
	laserPrim.top_radius = 0.2;
	laserPrim.bottom_radius = 0.2;
	mesh_instance.global_position = (start_point + intersection_point) / 2
	laserPrim.material = laser_mat
	mesh_instance.mesh = laserPrim
	
	cyl_shape.height = laserPrim.height
	cyl_shape.radius = laserPrim.top_radius
	collision_shape.shape = cyl_shape
	mesh_instance.add_child(collision_shape)
	
	get_tree().root.add_child(mesh_instance)
	var laser_rotation = (intersection_point - start_point).normalized();
	var rotation_basis = Basis.looking_at(laser_rotation, Vector3.UP)
	mesh_instance.rotation = rotation_basis.get_euler()
	mesh_instance.rotate_object_local(Vector3.RIGHT, deg_to_rad(90))
	
	#redundancy
	collision_shape.global_rotation = mesh_instance.global_rotation
