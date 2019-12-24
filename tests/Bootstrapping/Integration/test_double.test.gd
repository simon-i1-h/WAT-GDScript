extends WAT.Test

var director

func title():
	# Script Directors are responsible for setting up Test Double Scripts
	return "Given a Test Double"
	
func pre():
	director = direct.script("res://Examples/Scripts/calculator.gd")

func post():
	director = null

func test_When_we_call_an_add_method_that_we_have_not_directed():
	describe("When we call an add(x, y) method that we haven't directed")
	
	asserts.is_equal(4, director.double().add(2, 2), "Then we get the correct result")

func test_When_we_call_a_method_that_we_have_dummied():
	describe("When we call a method that we have dummied")

	director.method("add").dummy()

	asserts.is_null(director.double().add(2, 2), "Then we get null")

func test_When_we_call_a_method_that_we_have_stubbed_to_return_true():
	describe("When we call a method that we have stubbed to return true")

	director.method("add").stub(true)

	asserts.is_true(director.double().add(2, 2), "Then it returns true")

func test_When_we_call_a_method_that_we_have_stubbed_to_return_a_node():
	describe("When we call a method that we have stubbed to return a node")

	var node: Node = Node.new()
	director.method("add").stub(node)

	asserts.is_equal(node, director.double().add(2, 2), "Then it returns that same node")
	node.free()

func test_When_we_call_a_method_that_we_are_spying_on():
	# Add a not-called version?
	describe("When we call a method that we are spying on")

	director.method("add").spy()
	director.double().add(2, 2)

	asserts.was_called(director, "add", "Then we can see that it was called at least once")

func test_When_we_pass_arguments_to_a_method_call_that_we_are_spying_on():
	describe("When we pass arguments to a method call that we are spying on")
<<<<<<< HEAD
	
	director.method("add").spy()
	director.double().add(10, 10)
	
=======

	director.method("add").spy()
	director.double().add(10, 10)

>>>>>>> troubleshooting
	asserts.was_called_with_arguments(director, "add", [10, 10], "Then we can see that it was called with those arguments")

func test_When_we_call_a_method_that_was_stubbed_to_return_different_values_based_on_argument_patterns():
	describe("When we call a method that was stubbed to return different values based on argument patterns")
<<<<<<< HEAD
	
	director.method("add").stub(100).stub(1000, [1, 1])
	var double = director.double()
	
=======

	director.method("add").stub(100).stub(1000, [1, 1])
	var double = director.double()

>>>>>>> troubleshooting
	asserts.is_equal(100, double.add(2, 2), "Then it returns the default stubbed value when the arguments don't match any pattern")
	asserts.is_equal(1000, double.add(1, 1), "Then it returns the the corresponding value to the pattern the arguments matched")

func test_When_we_call_a_method_that_was_stubbed_with_an_argument_pattern_that_includes_a_non_primitive_object():
	describe("When we call a method that was stubbed with an argument pattern that includes a non-primitive object")
<<<<<<< HEAD
	
	var non_primitive_object: Node = Node.new()
	director.method("add").stub(9999, [0, non_primitive_object])
	
=======

	var non_primitive_object: Node = Node.new()
	director.method("add").stub(9999, [0, non_primitive_object])

>>>>>>> troubleshooting
	asserts.is_equal(9999, director.double().add(0, non_primitive_object), "Then it returns the corresponding value when the pattern matches")
	non_primitive_object.free()

func test_When_we_call_a_method_that_was_stubbed_with_a_partial_argument_pattern():
	describe("When we call a method that was stubbed with a partial (ie using any()) argument pattern")
<<<<<<< HEAD
	
	director.method("add").stub(9999, [10, any()])
	
	asserts.is_equal(9999, director.double().add(10, 42), "Then it returns the corresponding value when the partial pattern matches")
	
func test_When_we_call_a_method_that_we_stubbed_to_call_its_super_implementation_by_default():
	describe("When we call a method that we stubbed to call its super implementation by default")
	
	director.method("add").call_super()
	director.method("add").stub(9999, [10, 10])
	var double = director.double()
	
=======

	director.method("add").stub(9999, [10, any()])

	asserts.is_equal(9999, director.double().add(10, 42), "Then it returns the corresponding value when the partial pattern matches")

func test_When_we_call_a_method_that_we_stubbed_to_call_its_super_implementation_by_default():
	describe("When we call a method that we stubbed to call its super implementation by default")

	director.method("add").call_super()
	director.method("add").stub(9999, [10, 10])
	var double = director.double()

>>>>>>> troubleshooting
	asserts.is_equal(4, double.add(2, 2), "Then it calls its super implementation by default")
	asserts.is_equal(9999, double.add(10, 10), \
		"Then it does not call its super implementation when arguments patterns match a different return value")

func test_When_we_add_a_doubled_inner_class_to_it():
	describe("When we add an doubled inner class to it")

	var inner = direct.script("res://Examples/Scripts/calculator.gd", "Algebra")
<<<<<<< HEAD
	director.add_inner_class(inner, "Algebra")
	
	asserts.is_equal(TAU, director.double().Algebra.get_tau(), "Then we can call the static methods of that inner double")
	
func test_When_we_stubbed_a_keyword_method_by_passing_in_the_correct_keyword():
	describe("When we stubbed a keyworded method by passing in the correct keyword")
	
	director.method("pi", director.STATIC).stub(true, [])
	
=======
	print(inner != null)
	director.add_inner_class(inner, "Algebra")

	asserts.is_equal(TAU, director.double().Algebra.get_tau(), "Then we can call the static methods of that inner double")

func test_When_we_stubbed_a_keyword_method_by_passing_in_the_correct_keyword():
	describe("When we stubbed a keyworded method by passing in the correct keyword")

	director.method("pi", director.STATIC).stub(true, [])

>>>>>>> troubleshooting
	asserts.is_equal(director.double().pi(), true, "Then we can call it")