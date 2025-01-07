# Arrays

Bash provides three types of parameters: strings, integers and arrays.
Most of the time, string values are sufficient.
But when you have a list of values, you will use an array.

There are two kinds of arrays:

* numerically-indexed arrays that map an integer key to a string value,
* associative arrays that map a string key to a string value.

The first few sections of this document will cover numerically-indexed arrays (hereafter simply known as "arrays").
Details about associative arrays will show up at the end.

## Declaring and Initializing an Array Variable

You can initialize an array by assigning a parenthesized list of elements (possibly empty) to an variable.

```bash
myarray=( "one" "two" "three" )
```

As is standard with every variable assignment, there must be no spaces around the equal sign.

Note that there are no comma separators between the elements; it is a whitespace-separated list of strings.

In fact, the amount of whitespace inside the parentheses is completely arbitrary.
Newlines are allowed; use as many as you want to improve readability.

```bash
myarray=(
    "first element"
    "second element"
    "this is the last element"
)
```

Assigning a list of strings to an array variable in this manner will store the first string in index zero, the next string in index one, the next in index two, and so on.
It's possible to initialize a "sparse array" by specifying the indices you need.

```bash
raindrops=( [3]="Pling" [5]="Plang [7]="Plong" )
```

~~~~exercism/note
To reiterate: array indices are zero-based.
This snippet outputs "true":

```bash
myarray=( "one" "two" "three" )
[[ "${myarray[0]}" == "one" ]] && echo true || echo false
```
~~~~

You can use the `declare` (or `local` inside a function) command to specify that a variable will hold an array.

```bash
declare -a myarray
```

But it is more idiomatic to just assign a (perhaps empty) parenthesized list to initialize the variable.

## Accessing Elements of an Array

As you saw above, the syntax to access an array element is `${myarray[$index]}`.
The index is given in square brackets.
The curly braces are required.

~~~~exercism/note
For numerically-indexed arrays, the index is an arithmetic expression.
Bash [allows][arithmetic]:

> Within an [arithmetic] expression, shell variables may also be referenced by name without using the parameter expansion syntax.

This means that the `$` is not required for "simple" variable expansion.
You can access elements like this, which is a bit easier to read:

```bash
i=5
echo "${myarray[i]}"
```

[arithmetic]: https://www.gnu.org/software/bash/manual/bash.html#Shell-Arithmetic
~~~~

To assign to a particular array entry, use this syntax

```bash
myarray[10]="hello"
```

To _append_ to an array, use the `+=` concatenating-assigment operator, and use parentheses:

```bash
myarray+=( "new element" )
```

## Iterating over an Array

## Inspecting an Array

## Associative Arrays
