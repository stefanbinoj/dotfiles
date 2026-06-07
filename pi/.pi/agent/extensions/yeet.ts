import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

const YEET_PROMPT = `Commit staged changes with a single concise commit message.

Rules:
- Only inspect staged diff.
- Never stage, unstage, reset, restore, or push anything.
- If nothing is staged, say so and stop.
- Output exactly one line, no explanations or extra text.
- Prefer conventional commits when natural: type: subject.
- Allowed types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert.
- If conventional format feels forced, use a short natural message.
- Keep messages imperative, present tense, specific, and concise.`;

export default function (pi: ExtensionAPI) {
  pi.registerCommand("yeet", {
    description: "commit the currently staged repo changes",
    handler: async (args, ctx) => {
      const prompt = args?.trim()
        ? `${YEET_PROMPT}\n\nAdditional instructions from the user:\n${args.trim()}`
        : YEET_PROMPT;

      if (ctx.isIdle()) {
        pi.sendUserMessage(prompt);
      } else {
        pi.sendUserMessage(prompt, { deliverAs: "followUp" });
        ctx.ui.notify("Queued /yeet as a follow-up", "info");
      }
    },
  });
}
