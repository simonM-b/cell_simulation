extends LineEdit


var allowed_characters = "[A-Za-z]"


func _on_text_changed(new_text: String) -> void:
	var old_caret_position = caret_column

	var word = ''
	var regex = RegEx.new()
	regex.compile(allowed_characters)
	for valid_character in regex.search_all(new_text):
		word += valid_character.get_string()
	self.set_text(word)

	caret_column = old_caret_position
