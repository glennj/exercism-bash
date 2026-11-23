# Exercism Bash Track Agent Instructions

## LLM behaviour

Behavioral guidelines to reduce common LLM coding mistakes.
Adapted from [andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills), which is inspired by Andrej Karpathy's observations on LLM coding pitfalls.

**Tradeoff:** These guidelines bias toward caution over speed.
For trivial tasks, use judgment.

### 1. Think Before Coding

**Don't assume.**
**Don't hide confusion.**
**Surface tradeoffs.**

Before implementing:

- State your assumptions explicitly.
  If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so.
  Push back when warranted.
- If something is unclear, stop.
  Name what's confusing.
  Ask.

### 2. Simplicity First

**Minimum code that solves the problem.**
**Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

### 3. Surgical Changes

**Touch only what you must.**
**Clean up only your own mess.**

When editing existing code:

- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:

- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

### 4. Goal-Driven Execution

**Define success criteria.**
**Loop until verified.**

Transform tasks into verifiable goals:

- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:

```text
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently.
Weak criteria ("make it work") require constant clarification.

## Scope

This repository maintains the Exercism Bash track: exercises, tests, example solutions, documentation, configuration, and track tooling.

Students solve exercises on the Exercism website or in their own Exercism CLI workspaces.
Do not treat this repository as a student workspace or fill in student stubs with completed solutions.

Follow `POLICIES.md`.
Keep changes scoped to the requested exercise or track component, preserve existing work, and avoid unrelated formatting or generated-file churn.

## Exercise layout

Practice exercises live in `exercises/practice/<slug>/`.
Read each exercise's `.meta/config.json` to confirm its configured filenames.

- `<snake_slug>.sh`: student-facing stub; normally remains incomplete.
- `<snake_slug>.bats`: tests delivered to students.
- `.meta/example.sh`: reference solution; must pass all tests.
- `.meta/template.j2`: test-generation template, when present.
- `.meta/tests.toml`: canonical test selection and metadata.
- `.meta/config.json`: exercise metadata and file mappings.
- `.docs/`: student-facing instructions and documentation.
- `bats-extra.bash`: vendored Bats support/assertion library.

## Maintaining exercises

- Keep instructions, tests, example solutions, stubs, and metadata consistent.
- When tests change, ensure `.meta/example.sh` demonstrates the intended behavior and passes the complete test suite.
- Preserve the student-facing stub's intended level of guidance; do not turn it into another example solution.
- For exercises with `.meta/template.j2`, treat the `.bats` file as generated.
  Change the template or shared `bin/generator_macros.j2`, then regenerate rather than making generated edits that would be overwritten.
- Use canonical data from `problem-specifications` and `.meta/tests.toml`.
  Do not invent canonical UUIDs or silently omit canonical cases.
- Preserve the skip convention: the first skip directive is commented out and later tests have active directives.
  Validation uses `BATS_RUN_SKIPPED=true` to run all tests.
- Do not modify `bats-extra.bash` unless updating the vendored library is part of the task.

Regenerate tests only for affected exercises when possible:

```bash
bin/generate_tests two-fer
```

The generator requires Python 3.11 or newer, Jinja2, and the cached problem-specifications repository.
Report missing prerequisites rather than claiming generation succeeded.

## Skills

Task-specific skills live in `.agents/skills/`.
Use `.agents/skills/add-concept-exercise/SKILL.md` when adding a concept exercise for one of the concepts documented in `concepts/`.

## Bash conventions

- Target Bash, not POSIX `sh`; POSIX compatibility is not required.
- Follow `POLICIES.md`, including the Google Shell Style Guide, while matching the surrounding file's established style.
- Use `#!/usr/bin/env bash` where a shebang is needed.
- Quote expansions unless splitting or globbing is explicitly intended.
  Correctly handle whitespace, empty strings, and glob characters.
- Prefer clear Bash conditionals, arrays, functions, and builtins where appropriate.
  Use `local` for function-local variables.
- Ensure exercise programs produce exactly the output and exit status expected by their tests.
  Bats `run` collects both stdout and stderr in `$output`, so writing diagnostics to either stream can break `assert_output`, `refute_output`, and related assertions.
- When diagnostic output is needed while validating an exercise, write it to file descriptor 3 so Bats does not include it in `$output`:

  ```bash
  printf 'debug: value=%q\n' "$value" >&3
  ```

- In standalone track-maintenance scripts, such as those under `bin/` or `.github/scripts/`, write diagnostics to stderr instead:

  ```bash
  printf 'error: invalid exercise configuration\n' >&2
  ```

- Remove temporary diagnostic output before finishing unless the user explicitly asks to retain it.
- Avoid unnecessary dependencies and unrelated rewrites.
- Preserve LF line endings.

## Validation

After changing an exercise's tests, template, or example solution, run:

```bash
bin/validate_one_exercise exercises/practice/two-fer
```

This script copies the example solution, tests, `bats-extra.bash`, and any configured editor files into a temporary directory, then runs all Bats tests there against the example.
The temporary directory is removed on exit.
It validates the **example solution**, not student code.
The exercise directory, including the student-facing stub, is never modified, so uncommitted changes to it are safe.

Pass `-D` to run the tests inside the `exercism/bash-test-runner` Docker image instead of locally:

```bash
bin/validate_one_exercise -D exercises/practice/two-fer
```

For broad exercise changes, validate all exercises:

```bash
bin/validate_exercises
```

Run ShellCheck over active exercise shell files with:

```bash
bin/lint
```

For configuration or metadata changes, also run:

```bash
bin/configlet lint
```

Use `bin/fetch-configlet` only when configlet is needed and fetching it is acceptable.
Do not install global dependencies without approval.

Before finishing, inspect the relevant diff and working-tree status.
Report which checks ran and any that could not run; never claim unrun checks passed.
