extends Node
class_name WAT
tool

const TestDoubleFactory = preload("res://addons/WAT/core/double/factory.gd")
const Test: Script = preload("res://addons/WAT/core/test/test.gd")
const TestSuiteOfSuites = preload("res://addons/WAT/core/test/suite.gd")
const SignalWatcher = preload("res://addons/WAT/core/test/watcher.gd")
const Parameters = preload("res://addons/WAT/core/test/parameters.gd")
const Yielder = preload("res://addons/WAT/core/test/yielder.gd")
const Asserts = preload("res://addons/WAT/core/assertions/assertions.gd")
const TestCase = preload("res://addons/WAT/core/test/case.gd")
const Recorder = preload("res://addons/WAT/core/test/recorder.gd")
const Settings = preload("res://addons/WAT/globals/settings.gd")
const ResManager = preload("res://addons/WAT/globals/resourcemanager.gd")


class Icon:
	const SUCCESS = preload("res://addons/WAT/assets/passed.png")
	const FAILED = preload("res://addons/WAT/assets/failed.png")
	const SUPPORT = preload("res://addons/WAT/assets/kofi.png")
	const FOLDER = preload("res://addons/WAT/assets/folder.png")
	const SCRIPT = preload("res://addons/WAT/assets/script.png")
	const FUNCTION = preload("res://addons/WAT/assets/function.png")
	const RERUN_FAILED = preload("res://addons/WAT/assets/rerun_failures.png")
	const RUN = preload("res://addons/WAT/assets/play.png")
	const TAG = preload("res://addons/WAT/assets/label.png")
