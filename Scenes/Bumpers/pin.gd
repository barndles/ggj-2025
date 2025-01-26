extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var random: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var level: Node2D = get_tree().get_root().get_node("Level-1")
@onready var mainUI: Control = level.get_node("CanvasLayer/MainUI")
@onready var player: RigidBody2D = level.get_node("Player")

@export_enum("Space", "Sky", "Forest", "Hell") var pin_type:int
@export var sprite_textures:Array[Texture2D]

var sound: bool = false

func _ready() -> void:
	sprite_2d.texture = sprite_textures[pin_type]

func _on_area_2d_body_entered(body: Node2D) -> void:
	animation_player.play("pin_bonk")
	if sound:
		$Sound.pitch_scale = random.randf_range(0.75, 1.25)
		$Sound.play()
	mainUI.score += 1
	mainUI.get_node("Score").text = "Score: " + str(mainUI.score)

func _on_start_timer_timeout() -> void:
	sound = true
