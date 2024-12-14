class_name CapturedBody extends RigidBody3D

var black_hole_disappeared = false
var on_floor = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	var i = 0
	while i < state.get_contact_count():
		var normal = state.get_contact_local_normal(i)
		var this_contact_on_floor = normal.dot(Vector3.UP) > 0.99
		
		if this_contact_on_floor and black_hole_disappeared:
			var child = get_child(1)
			child.reparent(get_tree().current_scene)
			queue_free()
			break
		i += 1
		
