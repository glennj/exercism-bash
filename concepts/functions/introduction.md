# Functions

Many Bash scripts are written in a strictly imperative style: 
do a thing, then do another thing, and so on.
But often you'll need to have a group of commands that you'll need to execute, perhaps with different parameters.
This is where _functions_ come in.

## Function syntax

You declare a function is one of two ways. The first is a portable style
```bash
funcname () COMPOUND_COMMAND
```

This is the style that was created with the original Bourne shell.

Alternately, you can use the `function` keyword

```bash
function funcname COMPOUND_COMMAND
```

(which is better?)

Typically, the body of the function (the "COMPOUND_COMMAND") is a sequence of commands enclosed in braces:

- what are they
- how they are declared
- return status and output
- positional parameters
- local variables
- 
