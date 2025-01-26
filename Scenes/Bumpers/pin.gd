extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

@export_enum("Space", "Sky", "Forest", "Hell") var pin_type:int
@export var sprite_textures:Array[Texture2D]

func _ready() -> void:
	sprite_2d.texture = sprite_textures[pin_type]

func _on_area_2d_body_entered(body: Node2D) -> void:
	animation_player.play("pin_bonk")
