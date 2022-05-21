extends GutTest

const FP := preload("res://fp.gd")


func test_can_map():
	var input := [1, 2, 3]
	var function := funcref(self, "add_one")
	var expected_output := [2, 3, 4]
	assert_eq_shallow(FP.map(input, function), expected_output)


func test_can_filter():
	var input := [1, 2, 3, 4]
	var function := funcref(self, "is_even")
	var expected_output := [2, 4]
	assert_eq_shallow(FP.filter(input, function), expected_output)


func test_can_reduce():
	var input := [1, 2, 3]
	var function := funcref(self, "sum")
	var expected_output := 6
	assert_eq(FP.reduce(input, function), expected_output)


func test_can_pipe_multiple_funcrefs():
	var input := [1, 2, 3, 4]
	var expected_output := 8
	var output = FP.pipe(
		input,
		[
			[funcref(FP, "filter"), funcref(self, "is_even")],
			[funcref(FP, "map"), funcref(self, "add_one")],
			[funcref(FP, "reduce"), funcref(self, "sum")]
		]
	)
	assert_eq(output, expected_output)


static func add_one(num: int) -> int:
	return num + 1


static func is_even(num: int) -> bool:
	return num % 2 == 0


static func sum(a: int, b: int) -> int:
	return a + b
