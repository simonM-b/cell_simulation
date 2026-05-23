extends Node2D

@onready var cellSpawnerGroup = $spawners

var canPlace = true
const cellSpawnerPreLoad = preload("res://scenes+scripts/cell spawner.tscn")
const cellSpawnerEditorPreLoad = preload("res://scenes+scripts/cell_read_and_write.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func startNewCellEditorFile():
	return GLOBAL.createNewCellSpawnerFile()

func cellInitSpawningProcedure():
	var cellSpawner = cellSpawnerPreLoad.instantiate()
	cellSpawnerGroup.add_child(cellSpawner)
	cellSpawner.followCursor = true
	var file = startNewCellEditorFile()
	print(file)
	var cellSpawnerEditor = cellSpawnerEditorPreLoad.instantiate()
	cellSpawner.add_child(cellSpawnerEditor)
	cellSpawnerEditor.hide()
	cellSpawnerEditor.fileOpendName = file
	cellSpawnerEditor.open_file_in_window(file)
	
	


func _on_spawn_new_cell_pressed() -> void:
	canPlace = false
	cellInitSpawningProcedure()
