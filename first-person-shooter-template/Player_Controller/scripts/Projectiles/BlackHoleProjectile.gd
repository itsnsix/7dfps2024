class_name BlackHole extends Projectile

func _init() -> void:
	damage = 100
	Projectile_Velocity = 20
	Projectile_Type = "Rigidbody_Projectile"
	Rigid_Body_Projectile = preload("res://Material/BlackHoleMaterials/black_hole.tscn")
	
