extends Node2D

var followCursor = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if followCursor:
		global_position = get_global_mouse_position()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if followCursor:
				followCursor = false
				for i in get_children():
					if i.is_in_group("cell spawn editor"):
						i.show()
				

func _on_move_the_node_with_mouse_pressed() -> void:
	if !followCursor:
		followCursor = true


func _on_name_edit_text_changed(new_text: String) -> void:
	for i in get_children():
		if i.is_in_group("cell spawn editor"):
			i.title = str(new_text)
			
			
			
			
			
			
			
