# Hints

## General

- Quote your parameter expansions: `"$name"`.
- Double quotes allow expansions; single quotes do not.
- Read the [Quoting][quoting] section of the Bash manual, or the track's quoting concept page.

## 1. Print the name of the file you are looking at

- Use [`echo`][echo] with a double-quoted string that contains the variable.
- Put a backslash before a double quote to include it literally inside a double-quoted string: `"She said \"hi\""`.

## 2. Print the contents of the file

- `cat file` prints the contents of the file.
- If the file name contains a space and the variable is not quoted, `cat` receives two arguments instead of one.

## 3. Print a reminder

- Single quotes keep every character literal, including `*` and `$`.

## 4. Print the pattern and the files it matches

- An unquoted `*.txt` is replaced by the names of the matching files before `echo` runs.
- Quote the expansion to keep the pattern as a single, literal word.
- To list the matching files, leave the expansion _unquoted_ so that the shell expands the pattern.
  The shell does not split a file name that contains spaces: each matching file is one argument.
- `printf '%s\n' one two` prints `one` and `two` on separate lines: the format is reused for each argument.
- ShellCheck warns about an unquoted expansion.
  Here it is intentional, so you can ignore the warning.

## 5. Print the note

- Without quotes, the shell splits the value into words, and `echo` joins them with single spaces.
- Quote the expansion to keep the value exactly as it was given.

[quoting]: https://www.gnu.org/software/bash/manual/bash.html#Quoting
[echo]: https://www.gnu.org/software/bash/manual/bash.html#Bash-Builtins
