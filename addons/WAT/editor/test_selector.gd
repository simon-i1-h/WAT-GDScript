extends Button
tool

signal _test_path_selected
var tests: Dictionary = {}
onready var Directories: PopupMenu = $Directories
onready var Scripts: PopupMenu = $Directories/Scripts
onready var Methods: PopupMenu = $Directories/Scripts/Methods
onready var Tags: PopupMenu = $Directories/Tags


func _ready() -> void:
	# Dictionaries are referenced, meaning this is a pointer to the main dir
	tests = WAT.FileManager.tests
	Directories.connect("index_pressed", self, "_on_idx_pressed", [Directories])
	Scripts.connect("index_pressed", self, "_on_idx_pressed", [Scripts])
	Methods.connect("index_pressed", self, "_on_idx_pressed", [Methods])
	Tags.connect("index_pressed", self, "_on_idx_pressed", [Tags])
	
func _on_idx_pressed(idx: int, menu: PopupMenu) -> void:
	emit_signal("_test_path_selected", menu.get_item_metadata(idx))

func _on_Directories_about_to_show():
	Directories.clear()
	Directories.set_as_minsize()
	Directories.add_item("Run All")
	Directories.add_item("Rerun Failures")
	Directories.add_submenu_item("Tags", "Tags")
	Directories.set_item_metadata(0, tests[WAT.Settings.test_directory()])
	Directories.set_item_metadata(1, WAT.Settings.results().failed())
	Directories.set_item_icon(0, load("res://addons/WAT/assets/play.svg"))
	Directories.set_item_icon(1, load("res://addons/WAT/assets/rerun_failures.svg"))
	Directories.set_item_icon(2, load("res://addons/WAT/assets/label.svg"))
	var dirs: Array = tests.directories
	if dirs.empty():
		return
	var idx: int = Directories.get_item_count()
	for dir in dirs:
		if not tests[dir].empty():
			Directories.add_submenu_item(dir, "Scripts")
			Directories.set_item_icon(idx, load("res://addons/WAT/assets/folder.svg"))
			idx += 1


func _on_Tags_about_to_show():
	Tags.clear()
	Tags.set_as_minsize()
	var idx: int = Tags.get_item_count()
	for tag in ProjectSettings.get("WAT/Tags"):
		Tags.add_item(tag)
		Tags.set_item_metadata(idx, tests[tag])
		idx += 1


func _on_Scripts_about_to_show():
	Scripts.clear()
	Scripts.set_as_minsize()
	Scripts.add_item("Run All")
	Scripts.set_item_metadata(0, tests[Directories.get_item_text(Directories.get_current_index())])
	Scripts.set_item_icon(0, load("res://addons/WAT/assets/folder.svg"))
	var scripts: Array = tests[Directories.get_item_text(Directories.get_current_index())]
	if scripts.empty():
		return
	var idx: int = Scripts.get_item_count()
	for test in scripts:
		Scripts.add_submenu_item(test.path, "Methods")
		Scripts.set_item_icon(idx, load("res://addons/WAT/assets/script.svg"))
		idx += 1


func _on_Methods_about_to_show():
	Methods.clear()
	Methods.set_as_minsize()
	Methods.add_item("Run All")
	Methods.set_item_metadata(0, [tests[Scripts.get_item_text(Scripts.get_current_index())]])
	Methods.set_item_icon(0, load("res://addons/WAT/assets/script.svg"))
	var test = tests[Scripts.get_item_text(Scripts.get_current_index())]
	var methods = test.test.get_script_method_list()
	var idx: int = Methods.get_item_count()
	for method in methods:
		if method.name.begins_with("test"):
			var dupe = test.duplicate()
			dupe.method = method.name
			Methods.add_item(method.name)
			Methods.set_item_metadata(idx, [dupe])
			Methods.set_item_icon(idx, load("res://addons/WAT/assets/function.svg"))
			idx += 1

func _on_pressed():
	var position = rect_global_position
	position.y += rect_size.y
	Directories.rect_global_position = position
	Directories.rect_size = Vector2(rect_size.x, 0)
	Directories.grab_focus()
	Directories.popup()

func _on_QuickStart_pressed():
	emit_signal("_test_path_selected", tests[WAT.Settings.test_directory()])

