extends CanvasLayer

@export var player_health : Node = Global

func _on_player_injured(damage: int):
	$HealthValue.text = str(Global.player_health - damage)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.connect('player_injured', _on_player_injured)
	$HealthValue.text = str(Global.player_health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
