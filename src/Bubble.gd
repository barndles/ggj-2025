extends RigidBody2D

@onready var random: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	var randomScale: float = random.randf_range(0.15, 0.75)
	$Sprite2D.scale = Vector2(randomScale, randomScale)
	$Sprite2D.set_texture(load("res://gfx/bubbles/Bubble" + str(random.randi_range(1, 8)) + ".png"))
	angular_velocity = deg_to_rad(random.randi_range(10, 360))

func _on_timer_timeout() -> void:
	queue_free()
