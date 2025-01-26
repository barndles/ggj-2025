extends Control

@onready var cloudScene: PackedScene = preload("res://Scenes/Cloud.tscn")
@onready var bubbleScene: PackedScene = preload("res://Scenes/Bubble.tscn")

@onready var random: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	$Title.rotation_degrees = -10
	rotateTitle()
	pulseTitle()
	var cloudCount: int = 0
	while cloudCount < 16:
		var cloud: Area2D = cloudScene.instantiate()
		cloud.global_position = Vector2(random.randi_range(-1024, 1024), random.randi_range(0, 320))
		%Clouds.add_child(cloud)
		cloud.owner = %Clouds
		cloudCount += 1
	var bubbleCount: int = 0
	makeBubbles(random.randi_range(30, 50))
	var tween: Tween = get_tree().create_tween()
	tween.tween_property($Fader, "color", Color(0, 0, 0, 0), 1)
	await tween.finished
	$Fader.visible = false

func makeBubbles(bubbles: int) -> void:
	var bubbleCount: int = 0
	while bubbleCount < bubbles:
		var bubble: RigidBody2D = bubbleScene.instantiate()
		var spawnParent: Node2D = %BubbleSpawn.get_children().pick_random()
		bubble.global_position = spawnParent.get_children().pick_random().global_position
		match spawnParent.name:
			"Left":
				bubble.apply_impulse(Vector2(random.randi_range(100, 300), random.randi_range(-100, -300)))
			"Right":
				bubble.apply_impulse(Vector2(random.randi_range(-100, -300), random.randi_range(-100, -300)))
			"Top":
				bubble.apply_impulse(Vector2(random.randi_range(50, 100), random.randi_range(0, 10)))
			"Bottom":
				bubble.apply_impulse(Vector2(random.randi_range(50, 100), random.randi_range(-100, -300)))
		%Bubbles.add_child(bubble)
		bubble.owner = %Bubbles
		bubbleCount += 1
	%BubbleTimer.wait_time = random.randi_range(1, 3)
	%BubbleTimer.start()

func _on_bubble_timer_timeout() -> void:
	makeBubbles(random.randi_range(30, 50))

func rotateTitle() -> void:
	var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Title, "rotation_degrees", $Title.rotation_degrees * -1, 3)
	%RotateTimer.start()

func pulseTitle() -> void:
	$Title.scale = Vector2(1.15, 1.15)
	%PulseTimer.start()
	var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Title, "scale", Vector2(1, 1), 0.37)

func _on_pulse_timer_timeout() -> void:
	pulseTitle()

func _on_rotate_timer_timeout() -> void:
	rotateTitle()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_play_pressed() -> void:
	$Fader.visible = true
	var tween: Tween = get_tree().create_tween()
	tween.tween_property($Fader, "color", Color(0, 0, 0, 1), 1)
	await tween.finished
	get_tree().change_scene_to_file("res://Scenes/Levels/Level-1.tscn")

func _on_boundary_area_entered(area: Area2D) -> void:
	if area.name.substr(0, 5) == "Cloud":
		var cloud: Area2D = cloudScene.instantiate()
		if area.global_position.x < 0:
			cloud.global_position = Vector2(1200, random.randi_range(10, 330))
		else:
			cloud.global_position = Vector2(-292, random.randi_range(10, 330))
		%Clouds.add_child(cloud)
		cloud.owner = %Clouds
		area.queue_free()

func _on_play_mouse_entered() -> void:
	%Play.self_modulate = Color(1, 1, 1, 1)

func _on_quit_mouse_entered() -> void:
	%Quit.self_modulate = Color(1, 1, 1, 1)

func _on_play_mouse_exited() -> void:
	%Play.self_modulate = Color(0.8, 0.8, 0.8, 1)

func _on_quit_mouse_exited() -> void:
	%Quit.self_modulate = Color(0.8, 0.8, 0.8, 1)

func _on_play_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.pressed:
				%Play.self_modulate = Color(0.6, 0.6, 0.6, 1)
			else:
				_on_play_mouse_exited()
				_on_play_pressed()

func _on_quit_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.pressed:
				%Quit.self_modulate = Color(0.6, 0.6, 0.6, 1)
			else:
				_on_quit_mouse_exited()
				_on_quit_pressed()
