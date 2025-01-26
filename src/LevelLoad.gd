extends Node2D

@onready var level: Node2D = get_tree().get_root().get_node("Level-1")
@onready var mainUI: Control = level.get_node("CanvasLayer/MainUI")
@onready var player: RigidBody2D = level.get_node("Player")

@onready var balloonScene: PackedScene = preload("res://Scenes/Balloon.tscn")

func _ready() -> void:
	var balloonCount: int = 0
	while balloonCount < 8:
		var spawnPosition: Marker2D = get_node("BalloonLocations").get_children().pick_random()
		var balloon: Area2D = balloonScene.instantiate()
		balloon.global_position = spawnPosition.global_position
		get_node("Balloons").add_child(balloon)
		balloon.owner = get_node("Balloons")
		spawnPosition.queue_free()
		balloonCount += 1
		await get_tree().create_timer(0.1).timeout

func _on_boundary_body_entered(body: RigidBody2D) -> void:
	if body == player:
		mainUI.playerEscape()
