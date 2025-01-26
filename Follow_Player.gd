extends Node2D

@onready var camera: Node2D = $"."

@export var Target:PackedScene
@export var min_relative_position: float

var camera_position = Vector2(0,0)
var target_position = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Target == null:
		return


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Target == null:
		return
	camera_position = camera.position
	target_position = Target.position
	
	
