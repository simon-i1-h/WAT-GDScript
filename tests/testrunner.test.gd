extends WAT.Test

# Scene
# Loader
# Results
# CreationMethod
const TestRunner = preload("res://addons/WAT/runner/TestRunner.tscn")
const FakeConfig: Resource = preload("res://tests/mocks/fake_config.tres")
var _runner: Node
var _results: Resource
var _test_loader: Resource

func title():
	return "Given A TestRunner"
	
func pre():
	_runner = TestRunner.instance()
	_results = FakeConfig.test_results
	_test_loader = FakeConfig.test_loader
	_runner.name = "NotMainTestRunner"
	_runner.configure(FakeConfig)

func post():
	_runner.free()

func test_when_we_pass_in_one_passing_test() -> void:
	describe("When we pass in one passing test")

	_test_loader.deposit([DummyPassingTest])
	add_child(_runner)
	yield(until_signal(_runner, "ended", 1.0), YIELD)
	var results: Array = _results.withdraw()
	asserts.is_true(results.size() == 1, "Then we get one testcase result")
	asserts.is_true(results[0].success, "And it passes")
	remove_child(_runner)

func test_when_we_pass_in_two_passing_tests() -> void:
	describe("When we pass in two passing tests")

	_test_loader.deposit([DummyPassingTest, DummyPassingTest])
	add_child(_runner)
	yield(until_signal(_runner, "ended", 1.0), YIELD)
	var results: Array = _results.withdraw()
	var both_pass: bool = results[0].success and results[1].success
	asserts.is_true(results.size() == 2, "Then we get two testcase results")
	asserts.is_true(both_pass, "And both pass")
	remove_child(_runner)

func test_when_we_pass_in_one_failing_tests() -> void:
	describe("When we pass in one failing test")

	_test_loader.deposit([DummyFailingTest])
	add_child(_runner)
	yield(until_signal(_runner, "ended", 1.0), YIELD)
	var results: Array = _results.withdraw()
	asserts.is_true(results.size() == 1, "Then we get one testcase result")
	asserts.is_true(not results[0].success, "And it fails")
	remove_child(_runner)

func test_when_we_pass_in_two_failing_tests() -> void:
	describe("When we pass in two failing tests")

	_test_loader.deposit([DummyFailingTest, DummyFailingTest])
	add_child(_runner)
	yield(until_signal(_runner, "ended", 1.0), YIELD)
	var results: Array = _results.withdraw()
	var both_fail: bool = not results[0].success and not results[1].success
	asserts.is_true(results.size() == 2, "Then we get two testcase results")
	asserts.is_true(both_fail, "And both fail")
	remove_child(_runner)

func test_when_we_pass_in_one_passing_test_and_one_failing_test() -> void:
	describe("When we pass in one passing test and one failing test")

	_test_loader.deposit([DummyPassingTest, DummyFailingTest])
	add_child(_runner)
	yield(until_signal(_runner, "ended", 1.0), YIELD)
	var results: Array = _results.withdraw()
	asserts.is_true(results.size() == 2, "Then we get two testcase results")
	asserts.is_true(results[0].success, "And one test passes")
	asserts.is_true(not results[1].success, "And one test fails")
	remove_child(_runner)

class DummyPassingTest extends WAT.Test:
	
	func _init() -> void:
		get_script().set_meta("path", "%s.%s" % [get_script().get_path(), name])
		name = "Dummy Passing Test"

	func title():
		return "Passing Test"
		
	func test_easy_pass():
		describe("Easy Pass")
		
		asserts.is_true(true, "Easy Pass")
		
class DummyFailingTest extends WAT.Test:
	
	func _init() -> void:
		get_script().set_meta("path", "%s.%s" % [get_script().get_path(), name])
		name = "Dummy Failing Test"
	
	func title():
		return "Failing Test"
		
	func test_easy_fail():
		describe("Easy Fail")
		
		asserts.is_true(false, "Easy Fail")
