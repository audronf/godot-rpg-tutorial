extends KinematicBody2D

const ACCELERATION = 100
const MAX_SPEED = 100
const FRICTION = 500

var velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get(Constants.PLAYBACK_PARAMETER)

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if (input_vector != Vector2.ZERO):
		animationTree.set(Constants.IDLE_BLEND_POSITION_PARAMETER, input_vector)
		animationTree.set(Constants.RUN_BLEND_POSITION_PARAMETER, input_vector)
		animationState.travel(Constants.RUN)
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel(Constants.IDLE)
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)
