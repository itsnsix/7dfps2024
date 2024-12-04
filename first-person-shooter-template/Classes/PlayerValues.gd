class_name PlayerValues

signal player_injured(damage: int)

var health: int = 100
var health_str: RichTextLabel = RichTextLabel.new()


func _on_player_injured(damage: int):
	health -= damage
	if health <= 0:
		print('Ha you died bitch')
		health = 100
	health_str.text = str(health)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
