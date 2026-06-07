---
description: Create a concise handoff summary for starting a fresh new Pi session
argument-hint: "[summary focus]"
---
# Handoff Summary

Create a concise, accurate handoff summary for starting a fresh Pi session.

The optional user argument is a focus hint for the summary, such as a topic, region, architecture, bug, file, or decision that should receive extra attention:

```text
$ARGUMENTS
```

If a focus hint is provided, emphasize that topic while still covering the full session context. If no focus hint is provided, summarize the whole session normally.

Include only useful context. Do not dump the transcript. Do not include secrets, tokens, private keys, tool calls or credentials.

Always preserve/copy important technical details when they exist:

- Core architecture or design decisions
- Main logic and important code blocks/snippets
- Important imports, APIs, interfaces, data flow, or control flow
- CLI commands, scripts and meaningful outputs
- User-suggested changes, constraints, preferences, and expected result
- Files created, edited, read, or discussed

Use this format:

```markdown
# Handoff: <short title>

The below is a summary from a previous session. These are the important details to keep in mind while continuing the work.

## Summary
<concise summary of what this session was about, the user's intention, the expected result, and the current status>

## User Intent and Expected Result
- <what the user wanted>
- <what result the user expected>

## Focus Hint
<the optional focus hint from the user, or "None provided">

## Current Status
- <what is complete>
- <what is still pending, blocked, or uncertain>

## Important Actions and Changes
- <important actions taken>
- <files created/edited/read and what changed>

## Architecture / Core Logic / Important Code
- <architecture, core logic, important code snippets, imports, APIs, or data flow that the next session should preserve>

## Commands and Outputs
```bash
<important CLI commands, scripts, git commands, test/build commands, or other commands used or recommended>
```

<brief notes about meaningful command results or errors>

## Decisions and Constraints
- <decisions made and why>
- <user preferences, constraints, conventions, or gotchas>

## Suggested Next Steps
1. <first concrete step>
2. <second concrete step>
```
