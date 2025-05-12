extends CharacterBody3D

var ORIGINAL_SPEED
var SPEED = 3.0
var SPRINT_SPEED = 7.0
const JUMP_VELOCITY = 4.5
var sprint_slider
var sprint_drain_amount = 0.2
var sprint_refresh_amount = 0.4
var movable = false

func _ready() -> void:
	ORIGINAL_SPEED = SPEED
	sprint_slider = get_node("/root/" + get_tree().current_scene.name + "/UI/sprint_slider")
	
func _process(delta: float) -> void:
	if movable:
		if SPEED == SPRINT_SPEED:
			sprint_slider.value = sprint_slider.value - sprint_drain_amount * delta
			#print("value is at:" + str(sprint_slider.value))
			if sprint_slider.value <= sprint_slider.min_value:
				SPEED = ORIGINAL_SPEED
		if SPEED != SPRINT_SPEED:
			if sprint_slider != null and sprint_slider.value < sprint_slider.max_value: 
				sprint_slider.value = sprint_slider.value + sprint_refresh_amount * delta
			if sprint_slider != null and sprint_slider.value == sprint_slider.max_value:
				sprint_slider.visible = false
				
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if movable == true:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var input_dir := Input.get_vector("left", "right", "forward", "backward")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
			if Input.is_action_just_pressed("sprint"):
				sprint_slider.visible = true
				SPEED = SPRINT_SPEED
				
			if Input.is_action_just_released("sprint"):
				SPEED = ORIGINAL_SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()
		
	
