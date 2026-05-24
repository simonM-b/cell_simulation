extends Node2D

var followCursor = false
var titleName = ""

var spawnedCell = false

const cellPreload = preload("res://scenes+scripts/cell.tscn")

var colors = [
["RED", Color.RED], 
["ORANGE",Color.ORANGE], 
["YELLOW",Color.YELLOW],
["GREEN",Color.GREEN],
["BLUE",Color.BLUE],
["LAVENDER",Color.PURPLE],
["WHITE",Color.WHITE],
["BLACK",Color.BLACK]
]

var listOfCommands = [
	["spawnCell()",Callable(self, "spawnCell")],
	["setColor(",Callable(self, "setColor")]
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func spawnCell(line):
	print("cell spawned")
	spawnedCell = cellPreload.instantiate()
	$cells.add_child(spawnedCell)

func setColor(line):
	print("color set")
	for i in colors:
		if i[0] in line:
			print("THE COLOR", i)
			spawnedCell.modulate = i[1]
			
	
	#if spawnedCell:
	#	print("color worked")
	#	spawnedCell.modulate = color
	#else:
	#	print("YOU NEED TO SPAWN IN A CELL USE spawnCell()")

func runFile():
	for i in $cells.get_children():
		i.queue_free()
	
	var file = FileAccess.open("user://cells/"+str(GLOBAL.currentSavePath)+".slivercs", FileAccess.READ)
	var content = file.get_as_text()
	while not file.eof_reached():
		var line = file.get_line()
		#print("Current line: ", line)
		for i in listOfCommands:
			#print(i)
			if i[0] in line:
				i[1].call(line)


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
			titleName = str(new_text)
			i.title = str(new_text)
			
			
			
func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y,
		"titleName" : titleName
	}
	return save_dict
	

func _on_init_timeout() -> void:
	print("added name to cell spawner")
	print(titleName)
	$"name edit".text = titleName
