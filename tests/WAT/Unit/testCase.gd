extends WATTest

var case
var test

func title() -> String:
	return "TestCase"

func pre():
	self.test = WATTest.new()
	self.test.queue_free()
	self.case = load("res://addons/WAT/Runner/case.gd").new(self.test)


func test_calculate_passing_when_all_tests_passed() -> void:
	describe("Calculates result when there are only passing tests")

	# Arrange
	var add = {title = "add", expectations = [], total = 0, passed = 0, success = false, context = ""}
	var subtract = {title = "subtract", expectations = [], total = 0, passed = 0, success = false, context = ""}
	var divide = {title = "divide", expectations = [], total = 0, passed = 0, success = false, context = ""}
	add.expectations.append({success = true})
	subtract.expectations.append({success = true})
	divide.expectations.append({success = true})
	case.methods += [add, subtract, divide]

	# Act
	case.calculate()

	# Assert
	# Is this leaking implementation?
	expect.is_greater_than(case.total, 0, "there was at least one test")
	expect.is_equal(case.passed, case.total, "passing test count is equal to total test count")
	expect.is_true(case.success, "test passed")


func test_calculate_failure_when_there_are_no_tests() -> void:
	describe("Calculates result when there are no tests at all")

	# Act
	case.calculate()

	# Assert
	expect.is_false(case.success, "test failed")

func test_calculate_failure_when_there_are_failed_tests() -> void:
	describe("Calculates result when there are passing and failing tests")

	# Arrange
	var add = {title = "add", expectations = [], total = 0, passed = 0, success = false, context = ""}
	var subtract = {title = "subtract", expectations = [], total = 0, passed = 0, success = false, context = ""}
	var divide = {title = "divide", expectations = [], total = 0, passed = 0, success = false, context = ""}
	add.expectations.append({success = true})
	subtract.expectations.append({success = false})
	divide.expectations.append({success = true})
	case.methods += [add, subtract, divide]

	# Act
	case.calculate()

	# Assert
	expect.is_false(case.success, "test failed")
