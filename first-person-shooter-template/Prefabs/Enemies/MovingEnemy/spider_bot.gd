class_name SpiderBot extends EnemyBase

@onready var panel = $SpiderBot/Core/SubViewport/Panel
@onready var stylebox: StyleBoxFlat = panel.get_theme_stylebox("panel")
@onready var wakeup_ap: AnimationPlayer = $SpiderBot/WakeupAp
@onready var sleep_ap: AnimationPlayer = $SpiderBot/SleepAp

func _ready() -> void:
	wakeup_ap.connect('animation_finished', _on_wakeup_finished)
	sleep_ap.connect('animation_finished', _on_sleep_finished)

var idle_bg: Color = Color(256, 196, 0, 1)
var alert_bg: Color = Color(256, 0, 0, 1)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	match state:
		WAKEUP:
			if not wakeup_ap.is_playing():
				wakeup_ap.play('wakeup')
		SLEEP:
			if not wakeup_ap.is_playing():
				sleep_ap.play_backwards('wakeup')
			stylebox.set('bg_color', idle_bg)
			panel.add_theme_stylebox_override("panel", stylebox)
		ALERT:
			stylebox.set('bg_color', alert_bg)
			panel.add_theme_stylebox_override("panel", stylebox)

func _on_wakeup_finished(anim_name: StringName):
	state = ALERT
	
func _on_sleep_finished(anim_name: StringName):
	state = IDLE
	
	
	
	
	
	
	
