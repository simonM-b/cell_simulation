extends Sprite2D

var isTouchingOtherCell = false

func moveN(stepPX=40):
	position.y -= stepPX

func moveS(stepPX=40):
	position.y += stepPX
	
func moveW(stepPX=40):
	position.x -= stepPX

func moveE(stepPX=40):
	position.x += stepPX


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("cell"):
		isTouchingOtherCell = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("cell"):
		isTouchingOtherCell = false
	
	
	
	
	
