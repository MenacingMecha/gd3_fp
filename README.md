# gd3_fp
Minimal, single-file functional programming module for Godot Engine 3.0

Adapted from: https://georgemarques.com.br/functional-gdscript.pdf

## Usage
Preload the script to access the static functions

```gdscript
const FP := preload("res://fp.gd")
```

## Map
```gdscript
static func map(input: Array, function: FuncRef) -> Array:
```
Calls `function` on each element of `input`, returning the transformed outputs from `function`.

`function` is required to have a non-void output.

### Example

```gdscript
static func add_one(num: int) -> int:
	return num + 1

var input := [1, 2, 3]
var output := FP.map(input, funcref(self, "add_one"))  # [2, 3, 4]
```

## Filter
```gdscript
static func filter(input: Array, function: FuncRef) -> Array:
```

Calls `function` on each element of `input`, returning all the elements which returned `true`.

`function` should return a `bool`, but this is not required.

### Example
```gdscript
static func is_even(num: int) -> bool:
	return num % 2 == 0

var input := [1, 2, 3, 4]
var output := FP.filter(input, funcref(self, "is_even"))  # [2, 4]
```

## Reduce
```gdscript
static func reduce(input: Array, function: FuncRef, base = null):
```

Returns a single output value by calling `function` on each element of the array along with the accumalated result of each iteration.

`function` should take in two inputs.

`base` can optionally be used to define a starting value.

### Example
```gdscript
static func sum(a: int, b: int) -> int:
	return a + b

var input := [1, 2, 3]
var output := FP.reduce(input, funcref(self, "sum"))  # 6
```
