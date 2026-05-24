extends Window

@onready var textEdit = $MarginContainer/ScrollContainer/VBoxContainer/TextEdit

const docsPreload = preload("res://scenes+scripts/docs.tscn")

var fileOpendName = "test"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(fileOpendName)
	$MarginContainer/ScrollContainer/VBoxContainer/filefind.text = fileOpendName
	


func open_file_in_window(filePart):
	var file = FileAccess.open("user://cells/"+str(filePart)+".slivercs", FileAccess.READ)
	var content = file.get_as_text()
	textEdit.text = content
	
func save_to_file(filePart,content):
	var file = FileAccess.open("user://cells/"+str(filePart)+".slivercs", FileAccess.WRITE)
	file.store_string(content)
	#print(content,"S")


func _on_text_edit_text_changed() -> void:
	save_to_file(fileOpendName,textEdit.text)


func save():
	print("save called")
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
	GLOBAL.currentScriptSavePath = fileOpendName
	open_file_in_window(fileOpendName)


func _on_run_file_pressed() -> void:
	$"..".runFile()


func _on_open_docs_pressed() -> void:
	var doc = docsPreload.instantiate()
	add_child(doc)
