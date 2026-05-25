extends Node2D

var followCursor = false
var titleName = ""

var spawnedCell = false
var cellMoveAmount = 40
var waitTimeNextLine = 0
var isTouchingOtherCell = false

const cellPreload = preload("res://scenes+scripts/cell.tscn")

var listOfLines = []

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

var possibleIfs = [
	["touchingOtherCell()):",isTouchingOtherCell]
]

var ifIndex = [
	
]

var ifNumber = -1
var whileAliveOn = false
var continueThis = []

var listOfCommands = [
	["#",Callable(self, "nothing")],
	["spawnCell()",Callable(self, "spawnCell")],
	["setColor(",Callable(self, "setColor")],
	["randomMove()",Callable(self, "randomMove")],
	["sleep(",Callable(self, "sleep")],
	["whileAlive@:",Callable(self, "whileAlive")],
	["if(",Callable(self, "ifGameAsk")]
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()

func resetValuesAndStartAnew():
	whileAliveOn = false
	continueThis.clear()
	waitTimeNextLine = 0
	isTouchingOtherCell = false
	spawnedCell = false
	listOfLines.clear()
	
	for i in $cells.get_children():
		i.queue_free()

func runLinesFromFile(from,to):
	if to != "all":
		#print("running all lines")
		var id = 0
		for line in listOfLines:
			if id >= from and id <= to:
				#print(line)
				await wait(waitTimeNextLine)
				waitTimeNextLine = 0
				#print("Current line: ", line)
				for command in listOfCommands:
					#print(i)
					if command[0] in line:
						waitTimeNextLine = 0
						command[1].call(line,id)
						break
			id += 1
	else:
		#print("running lines from",from,"to",to)
		var id = 0
		for line in listOfLines:
			if id >= from:
				#print(line)
				await wait(waitTimeNextLine)
				waitTimeNextLine = 0
				#print("Current line: ", line)
				for command in listOfCommands:
					#print(i)
					if command[0] in line:
						waitTimeNextLine = 0
						command[1].call(line,id)
						break
			id += 1

func runFile():
	resetValuesAndStartAnew()
	
	var file = FileAccess.open("user://cells/"+str(GLOBAL.currentScriptSavePath)+".slivercs", FileAccess.READ)
	var content = file.get_as_text()
	while not file.eof_reached():
		var fileLine = file.get_line()
		listOfLines.append(fileLine)
	
	runLinesFromFile(0,"all")

#START-------------------------------------------------START

func nothing(line,id):
	return ""

func spawnCell(line,id):
	print("cell spawned")
	spawnedCell = cellPreload.instantiate()
	$cells.add_child(spawnedCell)
	
func ifGameAsk(line,id):
	if spawnedCell:
		print("if runing")
		for i in possibleIfs:
			if i[0] in line:
				if i[1]:
					pass
	else:
		print("error no cell")



func whileAlive(line,id):
	if spawnedCell:
		print("while alive")
		while spawnedCell:
			await runLinesFromFile(id+1,"all")
	else:
		print("running while")


func setColor(line,id):
	if spawnedCell:
		print("color set")
		for i in colors:
			if i[0] in line:
				#print("THE COLOR", i)
				spawnedCell.modulate = i[1]
	else:
		print("error no cell")
			
			
func randomMove(line,id):
	print("cell moved")
	var moveDir = ["N","S","W","E"]
	var randomDir = moveDir[randi_range(0, 3)]
	var tweenSpeed = 0.1
	var tween = get_tree().create_tween()
	if spawnedCell:
		if randomDir == "N":
			if spawnedCell.global_position.y > 0:
				tween.tween_property(spawnedCell, "position", Vector2(spawnedCell.position.x,spawnedCell.position.y - cellMoveAmount), tweenSpeed)
		elif randomDir == "S":
			if spawnedCell.global_position.y < 650:
				tween.tween_property(spawnedCell, "position", Vector2(spawnedCell.position.x,spawnedCell.position.y + cellMoveAmount), tweenSpeed)
		elif randomDir == "W":
			if spawnedCell.global_position.x > 0:
				tween.tween_property(spawnedCell, "position", Vector2(spawnedCell.position.x - cellMoveAmount,spawnedCell.position.y), tweenSpeed)
		elif randomDir == "E":
			if spawnedCell.global_position.x < 1150:
				tween.tween_property(spawnedCell, "position", Vector2(spawnedCell.position.x + cellMoveAmount,spawnedCell.position.y), tweenSpeed)
	else:
		print("error no cell")

func getNumberValInLine4digits(line,id):
	var regex = RegEx.new()
	regex.compile("[0-9]{1,4}")
	var result = regex.search(str(line))
	if result:
		return int(result.get_string())
	else:
		return 0
		
func sleep(line,id):
	if spawnedCell:
		waitTimeNextLine = getNumberValInLine4digits(line,id)
		print("sleeping",waitTimeNextLine)
	else:
		print("error no cell")
		
		
#END-------------------------------------------------END

func wait(seconds: float) -> void:
	#print("WWW waiting",seconds)
	await get_tree().create_timer(seconds).timeout
	#await wait(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if followCursor:
		global_position = get_global_mouse_position()
	if spawnedCell:
		isTouchingOtherCell = spawnedCell.isTouchingOtherCell

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
