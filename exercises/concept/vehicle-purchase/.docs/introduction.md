# Introduction

## Conditionals

### Truthiness in Bash

Bash does not have the concept of boolean values.
There are strings and numbers, and arrays of strings or numbers.
So how do conditional commands deal with true and false?

### Exit Status

Commands produce an _exit status_ when they end.
An exit status is an integer between 0 and 255 inclusive.
Bash considers a **zero** exit status to represent _success_.
Any other exit status represents _failure_.

This applies to all commands, including bash builtin commands, keywords, and functions.

### The "if" Command

The basic syntax of the `if` command is

```bash
if CONDITIONAL_COMMAND; then TRUE_COMMANDS; else FALSE_COMMANDS; fi
```

It starts with `if`; the condition command is separated from the "success" commands by `then`; and it is terminated with `fi`.
The `else` clause is optional.

The CONDITIONAL_COMMAND is executed, and

* if the exit status is zero (success), then the TRUE_COMMANDS are executed.
* if the exit status is non-zero (failure), then the FALSE_COMMANDS are executed, if they are present.

Cascading branches can be given with `elif`
```bash
if CONDITIONAL_COMMAND
then TRUE_COMMANDS
elif CONDITIONAL_COMMAND_2
then TRUE_COMMANDS_2
# more elif branches ...
else FALSE_COMMANDS
fi
```

There must be a semicolon or a newline before the `then`, `elif`, `else` and `fi` words.

To emphasize: it is the **exit status** of the conditional command that controls the flow.
As an example, `grep` returns 0 if a match is found, and 1 if a match is not found.
The `-q` option suppresses output, only producing the exit status.

```bash
if grep -q "my pattern" my_file; then echo "the pattern is found in the file"; fi
```

### "[" and "test" Commands

There is no special syntax around the CONDITIONAL_COMMAND.
You may be used to seeing if statements that look like this:

```if
if [ "$password" = "secure" ]; then
    echo "Welcome!"
fi
```

`[` is not special syntax.
It is a _command_ that evaluates the conditional expression and exits with a success/failure status.
Like all commands, whitespace is **required** between it and its arguments.

`[` is actually a synonym for the `test` command.
They are exactly the same, except that the last argument to `[` _must_ be `]`.

#### Conditional Expressions

Within `[` and `]`, you write a conditional expression.
Some typical conditional expressions include:

```bash
[ -f "$filename" ]             # file operations
[ "$string1" = "$string2" ]    # string comparisons
[ "$num1" -eq "$num2" ]        # arithmetic comparisons
```

The arithmetic comparison operators treat their operands as integers:

| Operator | True when the first number is |
| -------- | ----------------------------- |
| `-eq`    | equal to the second           |
| `-ne`    | not equal to the second       |
| `-lt`    | less than the second          |
| `-le`    | less than or equal to         |
| `-gt`    | greater than the second       |
| `-ge`    | greater than or equal to      |

There are many more operations available; they are listed in the [Bash Conditional Expressions][cond-expr] section of the manual.

Notice that all the variables above are quoted.
`test` and `[` are plain commands, so their arguments are subject to word splitting and filename expansion like any other command.
Remember to quote your variable expansions.

### "[[" Keyword

The [`[[...]]` conditional construct][cond-construct] is not a _command_, it is a **keyword**.
This means that, although it is handled like any other command, it has special parsing rules.
What's special about `[[` is that the variables expanded within it are not subject to _word splitting_ or _filename expansion_.
That means this command acts as you expect, even without quoting.

```bash
if [[ -n $str ]]; then echo "not empty"; else echo "empty"; fi
```

`[[` supports all the conditional expressions that `test` and `[` can handle.
In addition, `[[` provides

* the `=~` regular-expression matching operator,
* `==` and `!=` operate as a glob-pattern matching operator,
* `&&` and `||` as logical operators (special parsing rule),
* `<` and `>` as "bare" string comparison operators (special parsing rule: because these are redirection symbols, in `[` they must be escaped).

Do not use `<` and `>` to compare numbers.
They compare strings character by character, so `[[ 10 < 9 ]]` is true: "1" sorts before "9".
Use `-lt` and `-gt` for numbers.

It is widely held that these special features offer so much benefit that `[[` should be used exclusively.
(For example, the [Google Shell Style Guide][goog-test].)

## Arithmetic with `expr`

Bash has its own way to do arithmetic, which you will learn about later.
For now, you can use the external `expr` command.
It takes the numbers and the operators as separate arguments, so each must be a separate word, and it prints the result:

```bash
expr 7 - 2
# => 5
```

Combine it with command substitution to store the result in a variable.
Quote an operator that has a special meaning to Bash, such as `*`:

```bash
total=$(expr "$price" '*' 3 / 100)
```

[goog-test]: https://google.github.io/styleguide/shellguide.html#s6.3-tests
