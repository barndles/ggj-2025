extends AnimatedSprite2D

@onready var level: Node2D = get_tree().get_root().get_node("Level-1")
@onready var mainUI: Control = level.get_node("CanvasLayer/MainUI")
@onready var player: RigidBody2D = level.get_node("Player")

func _ready() -> void:
	play("default")

func _on_area_2d_body_entered(body: RigidBody2D) -> void:
	if body == player:
		player.get_node("CollisionShape2D").set_deferred("disabled", true)
		player.set_deferred("freeze", true)
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(player, "modulate", Color(1, 1, 1, 0), 1)
		mainUI.gameOver()
