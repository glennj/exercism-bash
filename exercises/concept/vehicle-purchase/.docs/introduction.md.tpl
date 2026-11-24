# Introduction

%{concept:conditionals}

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
