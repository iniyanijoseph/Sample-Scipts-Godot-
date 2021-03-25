extends KinematicBody

var velocity = Vector3.ZERO
var input = Vector3.ZERO
export(int, 0, 3000, 0) var acceleration = 1500
export(int, 0, 1000, 0) var speed = 300
var jump = true
export(int, 0, 1000, 0) var gravity = 500
export(int, 0, 1000, 0) var jumpforce = 300


func _physics_process(delta):
	input.x = (Input.get_action_strength("Right") - Input.get_action_strength("Left"))
	input.z = (Input.get_action_strength("Down") - Input.get_action_strength("Up"))
	if input != Vector3.ZERO:
		velocity.x = (velocity.move_toward(input*speed, acceleration*delta)).x
		velocity.z = (velocity.move_toward(input*speed, acceleration*delta)).z
	else:
		velocity.x = (velocity.move_toward(Vector3.ZERO, acceleration*delta)).x
		velocity.z = (velocity.move_toward(Vector3.ZERO, acceleration*delta)).z

	if Input.is_action_pressed("Jump") and jump:
		velocity.y = jumpforce

	velocity = move_and_slide(velocity, Vector3.UP)

	if is_on_floor():
		jump = true
		velocity.y = 0
	else:
		jump = false
		velocity.y -= gravity*delta
