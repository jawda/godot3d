extends Node3D


var sens = 0.005 #sensitivity

func _ready() -> void:
	#lock cursor to middle of screen and hides it
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) 
	pass
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		#get player object rotate based on mouse movement
		get_parent().rotate_y(-event.relative.x * sens)
		#rotate the head up and down
		rotate_x(-event.relative.y * sens)
		#control how far player can see
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))
	pass
