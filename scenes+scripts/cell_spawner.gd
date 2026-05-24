extends Node2D

var followCursor = false
var titleName = ""

var spawnedCell = false
var cellMoveAmount = 40
var waitTimeNextLine = 0

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
	["setColor(",Callable(self, "setColor")],
	["randomMove()",Callable(self, "randomMove")],
	["sleep(",Callable(self, "sleep")]
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()

func runFile():
	for i in $cells.get_children():
		i.queue_free()
	
	var file = FileAccess.open("user://cells/"+str(GLOBAL.currentScriptSavePath)+".slivercs", FileAccess.READ)
	var content = file.get_as_text()
	while not file.eof_reached():
		var line = file.get_line()
		
		await wait(waitTimeNextLine)
		#print("Current line: ", line)
		for i in listOfCommands:
			#print(i)
			if i[0] in line:
				waitTimeNextLine = 0
				i[1].call(line)
				break

#-------------------------------------------------

func spawnCell(line):
	print("cell spawned")
	spawnedCell = cellPreload.instantiate()
	$cells.add_child(spawnedCell)

func setColor(line):
	if spawnedCell:
		print("color set")
		for i in colors:
			if i[0] in line:
				#print("THE COLOR", i)
				spawnedCell.modulate = i[1]
	else:
		print("error no cell")
			
			
func randomMove(line):
	print("cell moved")
	var moveDir = ["N","S","W","E"]
	var randomDir = moveDir[randi_range(0, 3)]
	if spawnedCell:
		if randomDir == "N":
			spawnedCell.position.y -= cellMoveAmount
		elif randomDir == "S":
			spawnedCell.position.y += cellMoveAmount
		elif randomDir == "W":
			spawnedCell.position.x -= cellMoveAmount
		elif randomDir == "E":
			spawnedCell.position.x += cellMoveAmount
	else:
		print("error no cell")

func getNumberValInLine4digits(line):
	var regex = RegEx.new()
	regex.compile("[0-9]{1,4}")
	var result = regex.search(str(line))
	if result:
		return int(result.get_string())
	else:
		return 0
		
func sleep(line):
	if spawnedCell:
		waitTimeNextLine = getNumberValInLine4digits(line)
		print("sleeping",waitTimeNextLine)
	else:
		print("error no cell")
		
		
#-------------------------------------------------

func wait(seconds: float) -> void:
	#print("WWW waiting",seconds)
	await get_tree().create_timer(seconds).timeout
	#await wait(1)

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
	print("save called")
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
