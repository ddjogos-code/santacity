extends Node2D
@onready var bgm: AudioStreamPlayer = $BGM

func _ready() -> void:
	if bgm.stream:
		if bgm.stream.has_method("set_loop"):
			bgm.stream.set_loop(true)
			
	bgm.play()

func stop_bgm():
	if is_instance_valid(bgm) and bgm.playing:
		var tween = create_tween()
		tween.tween_property(bgm, "volume_db", -80, 1.5)
		tween.tween_callback(bgm.stop)
