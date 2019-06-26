extends HBoxContainer
tool

const CONFIG = preload("res://addons/WAT/Settings/Config.tres")
const IO = preload("res://addons/WAT/utils/input_output.gd")
onready var FolderSelect: OptionButton = $Folder/Select
onready var ScriptSelect: OptionButton = $TestScript/Select
onready var RunFolder: OptionButton = $Folder/Run
onready var RunScript: OptionButton = $TestScript/Run
onready var PrintStrayNodes: Button = $Debug/PrintStrayNodes
signal RUN
signal START_TIME

func run(path: String) -> void:
	emit_signal("START_TIME")
	emit_signal("RUN", path)

func _ready() -> void:
	_select_folder()
	_select_script()
	_connect()

func _connect():
	PrintStrayNodes.connect("pressed", self, "print_stray_nodes")
	FolderSelect.connect("pressed", self, "_select_folder")
	ScriptSelect.connect("pressed", self, "_select_script")
	RunFolder.connect("pressed", self, "_run_folder")
	RunScript.connect("pressed", self, "_run_script")

func _select_folder(path: String = CONFIG.main_test_folder) -> void:
	FolderSelect.clear()
	FolderSelect.add_item(path)
	for directory in IO.directory_list(path):
		FolderSelect.add_item(directory)

func _select_script() -> void:
	ScriptSelect.clear()
	for file in IO.file_list(_selected_folder()):
		if _valid_test(file.name) and file.path == ("%s/%s" % [_selected_folder(), file.name]):
			ScriptSelect.add_item(file.path)

func _run_folder() -> void:
	if _exists(FolderSelect):
		run(_selected_folder())

func _run_script() -> void:
	if _exists(ScriptSelect): 
		run(_selected_script())
	
func _exists(list: OptionButton) -> bool:
	if list.items.empty():
		OS.alert("Nothing to Run")
		return false
	return true

func _valid_test(file: String) -> bool:
	return file.ends_with(".gd")

func _selected_folder() -> String:
	return FolderSelect.get_item_text(FolderSelect.selected)
	
func _selected_script() -> String:
	return ScriptSelect.get_item_text(ScriptSelect.selected)