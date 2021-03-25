extends KinematicBody2D

var velocity = Vector2.ZERO
var input = Vector2.ZERO
export(int, 0, 3000, 0) var acceleration = 1500
export(int, 0, 1000, 0) var speed = 300
var jump = true
export(int, 0, 1000, 0) var gravity = 500
export(int, 0, 1000, 0) var jumpforce = 300

func _physics_process(delta):
	input.x = (Input.get_action_strength("Right") - Input.get_action_strength("Left"))
	if input != Vector2.ZERO:
		velocity.x = (velocity.move_toward(input*speed, acceleration*delta)).x
	else:
		velocity.x = (velocity.move_toward(Vector2.ZERO, acceleration*delta)).x

	if Input.is_action_pressed("Jump") and jump:
		velocity.y = -jumpforce

	velocity = move_and_slide(velocity, Vector2.UP)

	if is_on_floor():
		jump = true
		velocity.y = 0
	else:
		jump = false
		velocity.y += gravity*delta
