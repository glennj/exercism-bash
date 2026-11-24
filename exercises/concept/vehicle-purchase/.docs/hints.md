# Hints

## General

- Quote your variable expansions in conditional expressions when you use `[` or `test`.
  Inside `[[ ... ]]`, quoting is not required, but it does no harm.
- Read about [conditional constructs][conditional-constructs] in the Bash manual, or the track's conditionals concept page.

## 1. Determine if you will need a license

- Use an [`if` command][conditional-constructs] with an `else` branch.
- Use `[[ ... ]]` to compare the kind with `==`.
- Inside `[[ ... ]]`, you can combine two comparisons with `||`.

## 2. Choose between two potential vehicles to buy

- Inside `[[ ... ]]`, the `<` operator compares strings in dictionary order.
- Store the winning option in a variable, then build the sentence once.

## 3. Calculate an estimation for the price of a used vehicle

- Start by determining the percentage based on the age of the vehicle.
  Use an `if`, `elif`, `else` command.
- Compare numbers with `-lt` ("less than") and `-gt` ("greater than"), described in [Bash Conditional Expressions][cond-expr].
- To calculate the result, apply the percentage to the original price.
  For example, 30% of `x` can be calculated by multiplying `x` by `30` and dividing by `100`.
  See the `expr` section of the introduction.

[conditional-constructs]: https://www.gnu.org/software/bash/manual/bash.html#Conditional-Constructs
[cond-expr]: https://www.gnu.org/software/bash/manual/bash.html#Bash-Conditional-Expressions
