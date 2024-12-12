class_name PlayerValues

var health: int
var health_str: RichTextLabel
var position: Vector3

signal flashScreen

func _init() -> void:
	health = 100
	health_str = RichTextLabel.new()

func _on_player_injured(damage: int) -> void:
	health -= damage
	if health <= 0:
		print('Ha you died bitch')
		health = 100
	health_str.text = str(health)
	flashScreen.emit()
