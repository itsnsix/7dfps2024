extends Node

var player_values: PlayerValues = preload("res://Classes/PlayerValues.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_values.connect('player_injured', player_values._on_player_injured)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
