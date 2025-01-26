extends Area2D

@export var Balloon_Animals:Array[Texture2D]

@onready var level: Node2D = get_tree().get_root().get_node("Level-1")
@onready var mainUI: Control = level.get_node("CanvasLayer/MainUI")
@onready var player: RigidBody2D = level.get_node("Player")
@onready var balloon_sprite: Sprite2D = $Sprite2D

@onready var random: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	balloon_sprite.texture = Balloon_Animals.pick_random()
	var startRotate: Array = [20, -20]
	$Sprite2D.set_texture(load("res://gfx/balloon/balloon" + str(random.randi_range(1, 4)) + ".png"))
	$Sprite2D.rotation_degrees = startRotate.pick_random()
	spriteRotate()

func _on_rotate_timer_timeout() -> void:
	spriteRotate()

func spriteRotate() -> void:
	var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	if $Sprite2D.rotation_degrees == 20:
		tween.tween_property($Sprite2D, "rotation_degrees", -20, 3)
	elif $Sprite2D.rotation_degrees == -20:
		tween.tween_property($Sprite2D, "rotation_degrees", 20, 3)

func _on_body_entered(body: RigidBody2D) -> void:
	if body.name == "Player":
		mainUI.score += 100
		mainUI.get_node("Score").text = "Score: " + str(mainUI.score)
		if not mainUI.interrupted:
			mainUI.introInterrupt()
		else:
			mainUI.bublinkoSpeak(mainUI.bublinkoCollect.pick_random())
		mainUI.bublinkoAnger += 1
		var finalRotate: Array = [20, -20]
		var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT).set_parallel(true)
		tween.tween_property($Sprite2D, "rotation_degrees", finalRotate.pick_random(), 0.5)
		tween.tween_property($Sprite2D, "modulate", Color(1, 1, 1, 0), 0.5)
		tween.tween_property($Sprite2D, "scale", Vector2(0.15, 0.15), 0.5)
		await tween.finished
		queue_free()
