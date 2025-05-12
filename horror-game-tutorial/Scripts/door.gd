extends StaticBody3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var interactable = true
var opened = false

func interact():
	if interactable == true:
		interactable = false
		opened = !opened
		if opened == false:
			animation_player.play("close")
		else:
			animation_player.play("open")
		await get_tree().create_timer(1.0, false).timeout
		interactable = true
	pass
