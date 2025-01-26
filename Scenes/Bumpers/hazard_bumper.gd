extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var random: RandomNumberGenerator = RandomNumberGenerator.new()


@onready var bumper: Node2D = $"."
@onready var level: Node2D = get_tree().get_root().get_node("Level-1")
@onready var mainUI: Control = level.get_node("CanvasLayer/MainUI")
@onready var player: RigidBody2D = level.get_node("Player")

var sound: bool = false

var launch_angle = Vector2(0,0)
var launch_vector = Vector2(0,0)
@export var launch_power = 1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: RigidBody2D) -> void:
	
	animation_player.play("Bumper_Bonk")
	
	launch_angle = (body.global_position - bumper.global_position).normalized()
	launch_vector = launch_angle * launch_power
	
	if body == null:
		print("theres your issue man, youre dereferencing a null pointer. come on guys")
		return
	else:
		print(launch_vector)
		body.apply_impulse(launch_vector)
		if sound:
			$Sound.pitch_scale = random.randf_range(0.75, 1.25)
			$Sound.play()
		mainUI.score -= 100
		mainUI.get_node("Score").text = "Score: " + str(mainUI.score)

func _on_start_timer_timeout() -> void:
	sound = true
