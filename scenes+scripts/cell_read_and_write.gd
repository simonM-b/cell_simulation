extends Window

@onready var textEdit = $MarginContainer/ScrollContainer/VBoxContainer/TextEdit

var fileOpendName = "test"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func open_file_in_window(filePart):
	var file = FileAccess.open("user://cells/"+str(filePart)+".txt", FileAccess.READ)
	var content = file.get_as_text()
	textEdit.text = content
	
func save_to_file(filePart,content):
	var file = FileAccess.open("user://cells/"+str(filePart)+".txt", FileAccess.WRITE)
	file.store_string(content)
	print(content,"SAVED TO FILE SUPOSIDLEY")


func _on_text_edit_text_changed() -> void:
	save_to_file(fileOpendName,textEdit.text)
