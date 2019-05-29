extends WATTest

# has/does not have
# is/is not in range

const BaseExpectation: Script = preload("res://addons/WAT/expectations/base.gd")
var calc

func pre():
	self.calc = double_script(Calculator)
	self.calc.instance.add(2, 2)

func test_all_should_pass():
	expect.is_true(true, "true is true")
	expect.is_false(false, "false is false")
	expect.is_equal(1, 1, "1 == 1")
	expect.is_equal("Hello World", "Hello World", "'Hello World' == 'Hello World'")
	expect.is_equal(1.0, 1, "1 == 1.0")
	expect.is_not_equal(1, 2, "1 != 2")
	expect.is_not_equal(1.0, 2, "1.0 != 2")
	expect.is_not_equal('Hello', 'World', "'Hello' != 'World'")
	expect.is_null(null, "null == null")
	expect.is_not_null(1, "1 != null")
	expect.is_greater_than(2.0, 1, "2.0 > 1")
	expect.is_greater_than("Hello", "Bello", "Hello > Bello")
	expect.is_less_than(1, 2.0, "1 < 2.0")
	expect.is_less_than("Bello", "Hello", "Bello < Hello")
	expect.is_equal_or_greater_than(2.0, 2, "2.0 >= 2")
	expect.is_equal_or_greater_than(2.0, 1, "2.0 >= 1")
	expect.is_equal_or_less_than(2, 2.0, "2 <= 2.0")
	expect.is_equal_or_less_than(1, 2.0, "1 <= 2.0")
	expect.is_built_in_type(1, TYPE_INT, "1 is type int")
	expect.is_built_in_type(1.0, TYPE_REAL, "1 is type float")
	expect.is_not_built_in_type(1, TYPE_REAL, "1 is not type float")
	expect.is_not_built_in_type(1.0, TYPE_INT, "1.0 is not type int")
	expect.is_class_instance(self, WATTest, "self is WATTest instance")
	expect.is_not_class_instance(self, BaseExpectation, "self is not BaseExpectation")
	expect.has(3, [1, 2, 3], "[1,2,3] has 3")
	expect.does_not_have(4, [1, 2, 3], "[1, 2, 3] does not have 4")
	expect.is_in_range(5, 1, 10, "5 is in range 1-10")
	expect.is_not_in_range(0, 1, 10, "0 is not in range 1-10")
	expect.string_begins_with("Hell", "Hello World", "Hello World begins with Hell")
	expect.string_contains("ello", "Hello World", "Hello World contains ello")
	expect.string_ends_with("World", "Hello World", "Hello World ends with World")
	expect.string_does_not_begin_with("World", "Hello World", "Hello World does not begin with World")
	expect.string_does_not_contain("FooBar", "Hello World", "Hello World does not contain FooBar")
	expect.string_does_not_end_with("Hello", "Hello World", "Hello World does not end with Hello")
	
	# Some Double Specific Things
	expect.was_called(calc, "add", "add was called")
	expect.was_not_called(calc, "subtract", "subtract was not called")

func test_all_should_fail():
	expect.is_true(false, "false is true")
	expect.is_false(true, "true is false")
	expect.is_equal(1, 2, "1 == 2")
	expect.is_equal(1.0, 2, "1.0 == 2")
	expect.is_equal("Hello", "World", "'Hello' == 'World'")
	expect.is_not_equal(1.0, 1, "1.0 != 1")
	expect.is_not_equal('Hello World', 'Hello World', "'Hello World' != 'Hello World'")
	expect.is_not_equal(1, 1, "1 == 1")
	expect.is_null(1, "1 == null")
	expect.is_not_null(null, "null != null")
	expect.is_greater_than(1, 2.0, "1 > 2.0")
	expect.is_greater_than("Bello", "Hello", "Bello > Hello")
	expect.is_less_than(2.0, 1, "2.0 < 1")
	expect.is_less_than("Hello", "Bello", "Hello < Bello")
	expect.is_equal_or_greater_than(1, 2.0, "1 >= 2.0")
	expect.is_equal_or_less_than(2, 1, "2 > 1")
	expect.is_built_in_type(1, TYPE_REAL, "1 is type float")
	expect.is_built_in_type(1.0, TYPE_INT, "1.0 is type int")
	expect.is_not_built_in_type(1, TYPE_INT, "1 is not type int")
	expect.is_not_built_in_type(1.0, TYPE_REAL, "1.0 is not type float")
	expect.is_class_instance(self, BaseExpectation, "self is instance of BaseExpectation")
	expect.is_not_class_instance(self, WATTest, "self is not instance of WATTest")
	expect.has(4, [1, 2, 3], "[1, 2, 3] has 4")
	expect.does_not_have(3, [1, 2, 3], "[1,2,3] does not have 3")
	expect.is_in_range(0, 1, 10, "0 is in range 1-10")
	expect.is_not_in_range(5, 1, 10, "5 is not in range 1-10")
	expect.string_begins_with("World", "Hello World", "Hello World begins with World")
	expect.string_contains("FooBar", "Hello World", "Hello World contains FooBar")
	expect.string_ends_with("Hello", "Hello World", "Hello World ends with Hello")
	expect.string_does_not_begin_with("Hello", "Hello World", "Hello World does not begin with Hello")
	expect.string_does_not_contain("ello", "Hello World", "Hello World does not contain ello")
	expect.string_does_not_end_with("World", "Hello World", "Hello World does not end with World")
	
	# Some Double Specific things
	expect.was_called(calc, "subtract", "subtract was called")
	expect.was_not_called(calc, "add", "add was not called")






