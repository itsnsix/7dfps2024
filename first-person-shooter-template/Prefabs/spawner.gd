extends Node3D  # Can be changed to Node2D if needed

@export var spawn_interval: float = 5.0  # Time between spawns in seconds
@export var max_enemies: int = 10  # Maximum number of enemies that can exist simultaneously
@export var spawn_area_size: Vector3 = Vector3(5, 0, 5)  # Area where enemies can spawn

# List of enemy scenes to spawn from
@export var enemy_scenes: Array[PackedScene] = []

# Internal tracking
var spawn_timer: float = 0.0
var current_enemies: Array = []

func _ready():
	# Validate spawn list
	if enemy_scenes.is_empty():
		push_warning("No enemy scenes configured for spawner!")
	if Engine.is_editor_hint():
		var debug_mesh = BoxMesh.new()
		debug_mesh.size = spawn_area_size
		
		var mesh_instance = MeshInstance3D.new()
		mesh_instance.mesh = debug_mesh
		mesh_instance.transparency = 0.7
		mesh_instance.name = "SpawnAreaDebug"
		add_child(mesh_instance)

func _process(delta):
	# Increment spawn timer
	spawn_timer += delta
	
	# Check if it's time to spawn and we haven't hit max enemies
	if spawn_timer >= spawn_interval and current_enemies.size() < max_enemies:
		spawn_enemy()
		spawn_timer = 0.0  # Reset timer
	
	# Optional: Clean up dead/null enemies
	current_enemies = current_enemies.filter(func(enemy): return is_instance_valid(enemy))

func spawn_enemy():
	# Ensure we have scenes to spawn from
	if enemy_scenes.is_empty():
		return
	
	# Randomly select an enemy scene
	var enemy_scene = enemy_scenes.pick_random()
	var enemy_instance = enemy_scene.instantiate()
	
	# Randomize spawn position within defined area
	var spawn_position = Vector3(
		global_position.x + randf_range(-spawn_area_size.x/2, spawn_area_size.x/2),
		global_position.y,  # Keeps Y consistent with spawner
		global_position.z + randf_range(-spawn_area_size.z/2, spawn_area_size.z/2)
	)
	
	# Set enemy position
	enemy_instance.global_position = spawn_position
	
	# Add to scene and tracking array
	get_parent().add_child(enemy_instance)
	current_enemies.append(enemy_instance)

# Optional method to manually clear all spawned enemies
func clear_enemies():
	for enemy in current_enemies:
		if is_instance_valid(enemy):
			enemy.queue_free()
	current_enemies.clear()
