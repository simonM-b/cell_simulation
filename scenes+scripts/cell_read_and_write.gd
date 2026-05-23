extends Window

@onready var textEdit = $MarginContainer/ScrollContainer/VBoxContainer/TextEdit

var fileOpendName = "test"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(fileOpendName)
	$MarginContainer/ScrollContainer/VBoxContainer/filefind.text = fileOpendName


func open_file_in_window(filePart):
	var file = FileAccess.open("user://cells/"+str(filePart)+".txt", FileAccess.READ)
	var content = file.get_as_text()
	textEdit.text = content
	
func save_to_file(filePart,content):
	var file = FileAccess.open("user://cells/"+str(filePart)+".txt", FileAccess.WRITE)
	file.store_string(content)
	print(content,"S")


func _on_text_edit_text_changed() -> void:
	save_to_file(fileOpendName,textEdit.text)


func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y,
		"title" : title,
		"fileOpendName" : fileOpendName
	}
	return save_dict


func _on_open_file_if_not_called_timeout() -> void:
	print("loaded text")
	open_file_in_window(fileOpendName)
