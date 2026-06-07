/**
 * TPS Tracker Extension
 *
 * Tracks tokens per second for each assistant message during generation.
 */

import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

export default function (pi: ExtensionAPI) {
	/** Timestamp when the current assistant message event started. Used as a fallback. */
	let messageStart: number | null = null;
	/** Timestamp of the first streamed output delta for the current assistant message. */
	let streamStart: number | null = null;
	pi.on("message_start", async (event) => {
		if (event.message.role !== "assistant") return;
		messageStart = Date.now();
		streamStart = null;
	});

	pi.on("message_update", async (event) => {
		if (event.message.role !== "assistant") return;

		const streamEvent = event.assistantMessageEvent;
		const isOutputDelta =
			streamEvent.type === "text_delta" ||
			streamEvent.type === "thinking_delta" ||
			streamEvent.type === "toolcall_delta";

		if (!isOutputDelta) return;

		streamStart ??= Date.now();
	});

	pi.on("message_end", async (event, ctx) => {
		if (event.message.role !== "assistant") return;

		const messageTokens = event.message.usage.output;
		const timingStart = streamStart ?? messageStart;
		const elapsed = timingStart ? (Date.now() - timingStart) / 1000 : 0;
		const tps = messageTokens > 0 && elapsed > 0 ? Math.round(messageTokens / elapsed) : 0;

		const theme = ctx.ui.theme;
		const icon = theme.fg("success", "✓");
		const tpsLabel = tps > 0
			? theme.fg("accent", `${tps} tok/s`)
			: theme.fg("dim", "N/A");
		const detail = theme.fg("dim", `${messageTokens} tokens in ${elapsed.toFixed(1)}s streaming`);

		ctx.ui.notify(`${icon} ${tpsLabel}  ${detail}`, "info");

		messageStart = null;
		streamStart = null;
	});
}
