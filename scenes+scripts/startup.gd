extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_new_save_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes+scripts/make new save .tscn")


func _on_load_save_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes+scripts/load_game.tscn")
