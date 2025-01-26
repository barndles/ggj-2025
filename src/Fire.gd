extends AnimatedSprite2D

@onready var level: Node2D = get_tree().get_root().get_node("Level-1")
@onready var mainUI: Control = level.get_node("CanvasLayer/MainUI")
@onready var player: RigidBody2D = level.get_node("Player")

func _ready() -> void:
	play("default")

func _on_area_2d_body_entered(body: RigidBody2D) -> void:
	if body == player:
		mainUI.gameOver()
		get_tree().quit()
