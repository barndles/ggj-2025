extends Node2D

@export var Target:RigidBody2D

var mouse_position = Vector2(0,0)
var local_mouse_position_previous_frame = Vector2(0,0)
var ball_position = Vector2(0,0)
var blowing_vector = Vector2(0,0)

var ct = 0

var mouse_speed = 0
@export var blowing_power = 0.01


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Target == null:
		return

	ct += 1
	if ct < 5:
		mouse_position = get_global_mouse_position()
		local_mouse_position_previous_frame = get_local_mouse_position()
		ball_position = Target.global_position
		return
		
		
	mouse_position = get_global_mouse_position()
	ball_position = Target.global_position
	
	mouse_speed = abs(get_local_mouse_position() - local_mouse_position_previous_frame)
	blowing_vector = (ball_position - mouse_position).normalized() * mouse_speed
	
	Target.apply_force(blowing_vector * blowing_power)
	
	local_mouse_position_previous_frame = get_local_mouse_position()
