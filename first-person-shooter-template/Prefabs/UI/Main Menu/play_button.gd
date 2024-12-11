extends Button

func _ready():
	GameManager.set_state("MENU")

func _pressed():
	GameManager.set_state("PLAYING")
	GameManager.change_scene()
