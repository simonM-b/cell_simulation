extends Window


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_open_file_in_file_manager_pressed() -> void:
	OS.shell_open(ProjectSettings.globalize_path("user://docs"))


func _on_close_requested() -> void:
	queue_free()
