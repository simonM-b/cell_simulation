extends Node


var currentSavePath = "faultydefultbackup"
var firstTimeOnSave = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func createNewCellSpawnerFile(): #creates a new file and returns the path of that file
	var timeDateSigniture = str(Time.get_unix_time_from_system())+"_"+str(Time.get_date_string_from_system())
	var path = "user://cells/"+timeDateSigniture+".txt"
	create_file(path)
	return timeDateSigniture
	
func create_file(path):
	var content = "Hello World!"
	
	var file = FileAccess.open(path, FileAccess.WRITE)
	
	if file:
		file.close()
		# File is automatically closed when the variable goes out of scope, 
		# but you can call file.close() manually if needed.
	else:
		print("An error occurred while creating the file: ", FileAccess.get_open_error())
	
