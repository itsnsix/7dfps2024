class_name MountedEnemy extends MovingEnemy

@onready var panel = $TurretCore/SubViewport/Panel
@onready var stylebox: StyleBoxFlat = panel.get_theme_stylebox("panel")
@onready var ap: AnimationPlayer = $AnimationPlayer
var idle_bg: Color = Color(256, 196, 0, 1)
var alert_bg: Color = Color(256, 0, 0, 1)

func _init() -> void:
	speed = 0

func _process(delta: float) -> void:
	match state:
		PATROL:
			stylebox.set('bg_color', idle_bg)
			panel.add_theme_stylebox_override("panel", stylebox)
			ap.play('patrol')
		ALERT:
			ap.stop()
			stylebox.set('bg_color', alert_bg)
			panel.add_theme_stylebox_override("panel", stylebox)
