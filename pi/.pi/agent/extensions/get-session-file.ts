import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

/**
 * Copy the current session's JSONL file path to the clipboard.
 *
 * Usage:
 *   /get-session-file
 */

export default function (pi: ExtensionAPI) {
	pi.registerCommand("get-session-file", {
		description: "Copy the current session JSONL file path to the clipboard",
		handler: async (_args, ctx) => {
			const file = ctx.sessionManager.getSessionFile();

			if (!file) {
				ctx.ui.notify("No session file (ephemeral session)", "warning");
				return;
			}

			const script = `printf %s "$1" | pbcopy`;
			const result = await pi.exec("bash", ["-c", script, "_", file], { timeout: 5000 });

			if (result.code === 0) {
				ctx.ui.notify(`Copied: ${file}`, "info");
			} else {
				ctx.ui.notify(`Failed to copy: ${result.stderr.trim()}`, "error");
			}
		},
	});
}