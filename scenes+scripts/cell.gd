extends Sprite2D

var isTouchingOtherCell = false
var tweenSpeed = 0.1

func moveN(stepPX=40):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(position.x,position.y - stepPX), tweenSpeed)

func moveS(stepPX=40):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(position.x,position.y + stepPX), tweenSpeed)
	
func moveW(stepPX=40):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(position.x - stepPX,position.y), tweenSpeed)

func moveE(stepPX=40):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(position.x + stepPX,position.y), tweenSpeed)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("cell"):
		print("TRUE TOUCHING CELLS")
		isTouchingOtherCell = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("cell"):
		isTouchingOtherCell = false
	
	
	
	
	
