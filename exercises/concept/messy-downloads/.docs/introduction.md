# Introduction

## The Importance of Quoting

One piece of advice new bash programmers will hear over and over:

> Quote your variables!

Why is that?

When you expand a variable (like `$name`) you almost always want to use the _value_ of the variable as a single string (or number).
You don't want the value to be unexpectedly handled as two or more separate strings.

### Quoting

Quoting is the primary mechanism to ensure that a piece of text is treated as a single word.
There are two main type of quotes.

#### Double Quotes

Double quotes allow parameter expansion, arithmetic expansion and command substitution within them.

```bash
echo "This is bash version $BASH_VERSION"
```

You can include a literal double quote inside a double-quoted string by preceding it with a backslash.

```bash
echo "She said \"Let me teach you about bash.\""
```

#### Single quotes

Single quotes _do not allow_ any expansions inside them.

```bash
echo 'This is bash version $BASH_VERSION'
# ...^..................................^
# prints exactly: This is bash version $BASH_VERSION
```

### Importance of quoting

What's wrong with `echo $name`, exactly?

When the shell parses a line of code, it performs [several kinds of expansions][expansions], in order.
Two of the last expansions are _Word Splitting_ and _Filename Expansion_.

#### Word Splitting

Any results of parameter expansion, command substitution or arithmetic expansion _that did not occur within double quotes_ are eligible for "word splitting".
The shell splits the expanded result into separate words on spaces, tabs and newlines.

The `printf '%s\n'` command prints each of its arguments on a line of its own, so it shows how many words a command receives:

```bash
sentence="The quick  brown fox"
printf '%s\n' "$sentence"
```

outputs

```none
The quick  brown fox
```

But unquoted:

```bash
printf '%s\n' $sentence
```

outputs

```none
The
quick
brown
fox
```

Word splitting also discards repeated spaces: `echo $sentence` prints `The quick brown fox`, while `echo "$sentence"` preserves both spaces between `quick` and `brown`.

For a file named `my report.txt`, `cat $file` gives `cat` two arguments, `my` and `report.txt`.
`cat "$file"` gives it one.

#### Filename Expansion

"Glob" patterns are used to express a concise pattern to match a set of files.
For example, you might match all the Markdown files in a directory with `*.md`.

The most common glob wildcard characters are:

* `*` matches zero or more of any character,
* `?` matches exactly one of any character,
* `[...]` matches exactly one character from the set of characters listed inside the brackets.

You have probably used globs with `ls`:

```bash
ls *.md
```

Filename expansion is a feature of the _shell_, not of the `ls` program.
Before it runs `ls`, bash replaces the pattern with the names of the matching files.
If the directory contains `a.md` and `b.md`, then `ls` is run as `ls a.md b.md`: it never sees the `*`.
Every command gets the same treatment, which is why `echo *.md` prints the file names too.

The shell also expands the results of a parameter expansion that is not quoted, so a value that contains these characters can be replaced by a list of file names.
To print a literal asterisk, quote it:

```bash
echo *      # prints a list of files
echo "*"    # prints a literal asterisk
echo '*'    # prints a literal asterisk
```

The same goes for a variable that contains a pattern:

```bash
pattern='*.md'
echo $pattern      # prints a list of Markdown files
echo "$pattern"    # prints *.md
```

[expansions]: https://www.gnu.org/software/bash/manual/bash.html#Shell-Expansions
