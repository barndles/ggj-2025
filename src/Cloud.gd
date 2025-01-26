extends Area2D

@onready var random: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	name = "Cloud"
	$Sprite2D.set_texture(load("res://gfx/Cloud" + str(random.randi_range(1, 4)) + ".png"))
	var tween: Tween = get_tree().create_tween()
	if global_position.x < 0:
		tween.tween_property(self, "global_position:x", 1000, random.randi_range(20, 25))
	else:
		tween.tween_property(self, "global_position:x", -1000, random.randi_range(20, 25))
