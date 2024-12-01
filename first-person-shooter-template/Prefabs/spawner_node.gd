@tool
extends Node3D  # Can be changed to Node2D if needed

@export var spawn_interval : float = 5.0  # Time between spawns in seconds
@export var max_enemies : int = 10  # Maximum number of enemies that can exist simultaneously
@export var spawn_radius : float : set = _set_spawn_radius   # Area where enemies can spawn
@export var spawning_enabled : bool = true

# List of enemy scenes to spawn from
@export var enemy_scenes: Array[PackedScene] = []

# Internal tracking
var spawn_timer : float = 0.0
var current_enemies : Array = []

func _set_spawn_radius(_args : float):
	spawn_radius = _args

func _ready():
	# Validate spawn list
	if enemy_scenes.is_empty():
		push_warning("No enemy scenes configured for spawner!")

func _process(delta):
	if !spawning_enabled:
		return
	# Increment spawn timer
	spawn_timer += delta
	
	# Check if it's time to spawn and we haven't hit max enemies
	if spawn_timer >= spawn_interval and current_enemies.size() < max_enemies:
		spawn_enemy()
		spawn_timer = 0.0  # Reset timer
	
	# Optional: Clean up dead/null enemies
	current_enemies = current_enemies.filter(func(enemy): return is_instance_valid(enemy))
	if Engine.is_editor_hint():
		var box_center = global_position
		DebugDraw3D.draw_cylinder_ab(box_center-Vector3(0,1,0), box_center+Vector3(0,1,0),spawn_radius, Color(1,0,1,0.3))

func spawn_enemy():
	# Ensure we have scenes to spawn from
	if enemy_scenes.is_empty():
		return
	# Randomly select an enemy scene
	var enemy_scene = enemy_scenes.pick_random()
	var enemy_instance = enemy_scene.instantiate()
	
	# Randomize spawn position within defined area
	var spawn_position = Vector3(
		global_position.x + randf_range(-spawn_radius/2, spawn_radius/2),
		global_position.y,  # Keeps Y consistent with spawner
		global_position.z + randf_range(-spawn_radius/2, spawn_radius/2)
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
