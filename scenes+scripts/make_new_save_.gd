extends Control

@onready var lineEdit  = $MarginContainer/CenterContainer/VBoxContainer/VBoxContainer/LineEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes+scripts/startup.tscn")


func _on_line_edit_text_submitted(new_text: String) -> void:
	GLOBAL.currentSavePath = "user://general_save_files/"+str(new_text)+".save"
	GLOBAL.firstTimeOnSave = true
	get_tree().change_scene_to_file("res://scenes+scripts/main_play_space.tscn")
	
	
