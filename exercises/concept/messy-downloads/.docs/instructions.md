# Instructions

Your downloads folder is a mess.
Some of the files have spaces in their names, some have square brackets, and you are nervous about running commands that might expand something you did not intend.

You are going to write a script that inspects one file safely.
Each task adds to the same script, so preserve the output from the previous tasks.
Do not print anything other than the requested output.

The script accepts three command-line arguments:

1. the name of a file in the current directory.
   The name may contain spaces or other unusual characters.
2. a filename pattern, such as `*.txt`.
3. a short note, which may contain repeated spaces.

You learned about positional parameters (`$1`, `$2`, and so on) in the Variables concept.
They hold these three arguments.

Run the script with:

```bash
bash messy_downloads.sh 'my report.txt' '*.txt' 'keep   these   spaces'
```

The examples below assume the current directory contains these files:

- `a.txt`
- `b.txt`
- `my report.txt`, which contains `hello downloads`
- `notes [v2].txt`

## 1. Print the name of the file you are looking at

Print the name of the file, surrounded by double quotes, after the words `Looking at`:

```text
Looking at "my report.txt"
```

## 2. Print the contents of the file

Use `cat` to print the contents of the file given as the first argument.

```text
hello downloads
```

## 3. Print a reminder

Print the following reminder exactly as shown.
The `*` and the `$HOME` must appear literally: nothing in the line should be expanded.

```text
Careful: rm * deletes everything and $HOME is your home directory
```

## 4. Print the pattern and the files it matches

Print the pattern from the second argument, after the word `Pattern:`.
The pattern must be printed as it was given, not replaced by the names of the files that match it.

Then print the files that the pattern matches, one per line.
This time you _want_ the shell to expand the pattern.
Use `printf '%s\n'`, which prints each of its arguments on its own line.

```text
Pattern: *.txt
a.txt
b.txt
my report.txt
notes [v2].txt
```

## 5. Print the note

Print the note from the third argument, after the word `Note:`.
Repeated spaces in the note must be preserved.

```text
Note: keep   these   spaces
```
