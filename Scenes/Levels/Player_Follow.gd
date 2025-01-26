extends Camera2D

@export var Target:RigidBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Target == null:
		return
	
	global_position = Vector2(480, lerp(global_position.y, Target.global_position.y, 0.2))
