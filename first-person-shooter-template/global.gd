extends Node

var player_values: PlayerValues
var ammo: RichTextLabel
var reserve_ammo: RichTextLabel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_values = preload("res://Classes/PlayerValues.gd").new()
	ammo = RichTextLabel.new()
	reserve_ammo = RichTextLabel.new()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
