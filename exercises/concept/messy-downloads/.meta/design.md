# Design

## Goal

The goal of this exercise is to introduce quoting in Bash scripts.

## Learning objectives

- Use double quotes to include a variable's value in a string.
- Embed literal double quotes inside a double-quoted string with a backslash.
- Use single quotes to prevent every expansion.
- Quote parameter expansions so a value containing spaces stays a single word.
- Quote parameter expansions so glob characters in a value are not expanded to file names.
- See the effect of an unquoted expansion, by contrasting a quoted pattern with an unquoted one that expands to file names.
- Know that quoting preserves repeated whitespace.

## Out of scope

- Changing `IFS`.
- Disabling filename expansion with `set -f` or tuning it with `shopt`.
- Extended glob patterns and character-class details.
- Embedding a single quote in a single-quoted string, and `$'...'` quoting.
- Quoting inside loops, arrays, and `[[ ]]` tests.
- Pipelines, such as quoting the arguments of `tr`.

## Concepts

The Concepts this exercise unlocks are:

- `quoting`

## Prerequisites

- `commands-and-arguments`
- `variables`
