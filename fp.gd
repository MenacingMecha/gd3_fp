# Static service class for higher-order functions
# Will become obsolete in 4.0
# Adapted from: https://georgemarques.com.br/functional-gdscript.pdf


# Calls `function` on each element of `input`, returning the transformed outputs from `function`
# `function` is required to have a non-void output
static func map(input: Array, function: FuncRef) -> Array:
	var result := []
	result.resize(input.size())

	for i in range(input.size()):
		result[i] = function.call_func(input[i])

	return result


# Calls `function` on each element of `input`, returning all the elements which returned `true`
# `function` should return a `bool`, but this is not required
static func filter(input: Array, function: FuncRef) -> Array:
	var result := []

	for element in input:
		if function.call_func(element):
			result.append(element)

	return result


# Returns a single output value by calling `function` on each element of the array along with the accumalated result of each iteration
# `function` should take in two inputs
# `base` can optionally be used to define a starting value
static func reduce(input: Array, function: FuncRef, base = null):
	var accumulator = base
	var index := 0

	if not base and input.size() > 0:
		accumulator = input[0]
		index = 1

	while index < input.size():
		accumulator = function.call_func(accumulator, input[index])
		index += 1

	return accumulator
