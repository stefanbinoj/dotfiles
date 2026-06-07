---
description: Simplify code while preserving behavior
argument-hint: "[files or instructions]"
---
# Code Simplifier

Simplify the requested code while preserving behavior.

User arguments:

```text
$ARGUMENTS
```

Scope:

- If the user provides file paths, simplify the whole requested file(s).
- If the user provides instructions without file paths, follow those instructions within the default scope.
- If no file is provided, default to untracked files and unstaged changes only.
- For tracked files in the default scope, only account for unstaged hunks/changes. Do not include staged hunks from the same file.
- For untracked files in the default scope, the whole file is in scope.

Useful commands for inspecting the default scope:

```bash
git status --short
git diff -- <file>                       # view unstaged changes for a tracked file
git diff --name-only                     # list tracked files with unstaged changes
git ls-files --others --exclude-standard # list untracked files
```

Goal:

Make the code simple, minimal, and easy for a human to read and maintain. Prefer code that a beginner can understand without feeling overwhelmed.

Rules:

- Preserve behavior exactly.
- Keep changes small and focused.
- Remove dead code.
- Remove comments that do not add useful meaning.
- Remove unnecessary helper functions, abstractions, or patterns when the logic is clearer inline.
- Reduce unnecessary nesting, duplication, indirection, and complexity.
- Prefer readable, explicit code over clever or overly compact code.
- Improve names only when it clearly helps readability.
- Follow the style already used in the project.
- Do not broaden scope beyond the requested files/code, except when no file is provided and untracked files plus unstaged changes define the default scope.
- If behavior is unclear, ask one concise question before editing.

Process:

1. Determine scope:
   - If file paths are provided, inspect and simplify those whole files.
   - If no file paths are provided, inspect untracked files and unstaged changes only.
2. Identify readability and maintainability improvements.
3. Make the minimal safe simplifications.
4. Run relevant checks if available.
5. Summarize what changed and mention any checks run.
