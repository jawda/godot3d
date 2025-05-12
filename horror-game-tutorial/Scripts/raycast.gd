extends RayCast3D

var int_text

func _ready() -> void:
	var node = get_node("/root/" + get_tree().current_scene.name + "/UI/interact_text")
	if node != null:
		int_text = node
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
		
	if is_colliding():
		var hit = get_collider()
		if hit.has_method("interact"):
			int_text.visible = true
			if Input.is_action_just_pressed("interact"):
				hit.interact()
		else:
			int_text.visible = false
	else:
			int_text.visible = false
	pass
