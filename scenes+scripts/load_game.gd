extends Control

@onready var buttonContainer = $"MarginContainer/CenterContainer/VBoxContainer/ScrollContainer/VBoxContainer/save button container"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in list_files_in_directory("user://general_save_files/"):
		var a = Button.new()
		buttonContainer.add_child(a)
		a.text = str(i).replace('.save', '')
		
	for button in buttonContainer.get_children():
		button.pressed.connect(on_pressed.bind(button))


func on_pressed(button):
	GLOBAL.firstTimeOnSave = false
	GLOBAL.currentSavePath = "user://general_save_files/"+str(button.text)+".save"
	get_tree().change_scene_to_file("res://scenes+scripts/main_play_space.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func list_files_in_directory(path):
	var files = []
	var dir = DirAccess.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()

	return files


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes+scripts/startup.tscn")
