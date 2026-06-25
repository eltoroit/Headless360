#!/usr/bin/env node
/**
 * Headless360 — Exercise 0 Setup
 * Full Node.js replacement for setup.sh + publishSite.mjs
 */

import { spawnSync, spawn } from "child_process";
import { writeFileSync, readFileSync, mkdirSync, openSync } from "fs";
import { createInterface } from "readline";
import { join } from "path";

const ROOT = new URL("..", import.meta.url).pathname;
const LOGS = join(ROOT, "etLogs");

mkdirSync(LOGS, { recursive: true });

// ─── pager ──────────────────────────────────────────────────────────────────

function pageOutput(text, pageSize = 30) {
	const lines = text.split("\n");
	return new Promise((resolve) => {
		const rl = createInterface({ input: process.stdin, output: process.stdout });
		let i = 0;
		const printNext = () => {
			const chunk = lines.slice(i, i + pageSize).join("\n");
			if (!chunk) {
				rl.close();
				resolve();
				return;
			}
			console.log(chunk);
			i += pageSize;
			if (i < lines.length) rl.question("-- more (Enter) --", printNext);
			else {
				rl.close();
				resolve();
			}
		};
		printNext();
	});
}

// ─── step runner ────────────────────────────────────────────────────────────

function parseCommand(cmdStr) {
	// Extract shell redirect: > logfile
	const redirectMatch = cmdStr.match(/\s+>\s+(\S+)\s*$/);
	const logPath = redirectMatch ? join(ROOT, redirectMatch[1]) : null;
	const cleanCmd = redirectMatch ? cmdStr.slice(0, redirectMatch.index) : cmdStr;

	// Tokenize respecting double and single quotes (handles --flag="val with spaces")
	const tokens = [];
	let current = "";
	let i = 0;
	while (i < cleanCmd.length) {
		const ch = cleanCmd[i];
		if (ch === " " || ch === "\t") {
			if (current) {
				tokens.push(current);
				current = "";
			}
			i++;
		} else if (ch === '"') {
			i++;
			while (i < cleanCmd.length && cleanCmd[i] !== '"') current += cleanCmd[i++];
			i++;
		} else if (ch === "'") {
			i++;
			while (i < cleanCmd.length && cleanCmd[i] !== "'") current += cleanCmd[i++];
			i++;
		} else {
			current += ch;
			i++;
		}
	}
	if (current) tokens.push(current);

	return { exe: tokens[0], args: tokens.slice(1), logPath };
}

function runStep({ label, command, failsAcepted }) {
	const { exe, args, logPath } = parseCommand(command);
	const result = spawnSync(exe, args, { encoding: "utf8" });

	if (result.error) throw new Error(`[${label}] spawn failed: ${result.error.message}`);

	if (logPath) writeFileSync(logPath, result.stdout ?? result.stderr ?? "");

	if (result.status !== 0) {
		const detail = (result.stdout || result.stderr || "no output").trim();
		if (failsAcepted) {
			console.error(`[${label}] exited ${result.status}:\n${detail}`);
		} else {
			throw new Error(`[${label}] exited ${result.status}:\n${detail}`);
		}
	}

	return result;
}

// Runs a command with stdio:inherit so TTY animations (sf deploy progress bars)
// render live. The `>` redirect in the command string is handled by writing
// stdout to the log file via a file descriptor instead of shell redirection.
function runStepPassthrough({ label, command, failsAcepted }) {
	const { exe, args, logPath } = parseCommand(command);
	// Remove the redirect arg pair that parseCommand already extracted into logPath
	const cleanArgs = logPath
		? args.filter((a) => a !== logPath && a !== ">")
		: args;

	const stdoutFd = logPath ? openSync(logPath, "w") : "inherit";
	const result = spawnSync(exe, cleanArgs, {
		stdio: ["inherit", stdoutFd, "inherit"],
		encoding: "utf8",
	});

	if (result.error) throw new Error(`[${label}] spawn failed: ${result.error.message}`);

	if (result.status !== 0) {
		const detail = (result.stdout || result.stderr || "no output").trim();
		if (failsAcepted) {
			console.error(`[${label}] exited ${result.status}:\n${detail}`);
		} else {
			throw new Error(`[${label}] exited ${result.status}:\n${detail}`);
		}
	}

	return result;
}

// ─── animated step runner ────────────────────────────────────────────────────

const SPINNER_FRAMES = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"];
const isTTY = process.stdout.isTTY === true;
const SPIN_MS = 80; // frame rate
const SEC_MS = 1000; // elapsed counter rate

function spinnerWrite(frame, animLabel, elapsed) {
	if (isTTY) {
		process.stdout.clearLine(0);
		process.stdout.cursorTo(0);
		process.stdout.write(`   ${frame} ${animLabel} (${elapsed}s)...`);
	} else if (elapsed % 10 === 0) {
		// Non-TTY (piped): one line every 10 s so logs aren't flooded
		process.stdout.write(`   ${animLabel}... ${elapsed}s\n`);
	}
}

function spinnerClear() {
	if (isTTY) {
		process.stdout.clearLine(0);
		process.stdout.cursorTo(0);
	}
}

function startSpinner(animLabel) {
	let frameIdx = 0;
	let elapsed = 0;
	spinnerWrite(SPINNER_FRAMES[0], animLabel, 0);

	const frameTimer = setInterval(() => {
		frameIdx++;
		spinnerWrite(SPINNER_FRAMES[frameIdx % SPINNER_FRAMES.length], animLabel, elapsed);
	}, SPIN_MS);

	const secTimer = setInterval(() => {
		elapsed++;
	}, SEC_MS);

	return () => {
		clearInterval(frameTimer);
		clearInterval(secTimer);
		spinnerClear();
	};
}

function runStepAnimated({ label, command, animLabel, failsAcepted }) {
	const { exe, args, logPath } = parseCommand(command);
	const stopSpinner = startSpinner(animLabel);

	return new Promise((resolve, reject) => {
		let stdout = "";
		let stderr = "";
		const child = spawn(exe, args, { encoding: "utf8" });

		child.stdout?.on("data", (d) => (stdout += d));
		child.stderr?.on("data", (d) => (stderr += d));

		child.on("error", (err) => {
			stopSpinner();
			reject(new Error(`[${label}] spawn failed: ${err.message}`));
		});

		child.on("close", (code) => {
			stopSpinner();
			if (logPath) writeFileSync(logPath, stdout || stderr || "");
			if (code !== 0) {
				const detail = (stdout || stderr || "no output").trim();
				if (failsAcepted) {
					console.error(`[${label}] exited ${code}:\n${detail}`);
					resolve({ stdout, stderr, status: code });
				} else {
					reject(new Error(`[${label}] exited ${code}:\n${detail}`));
				}
			} else {
				resolve({ stdout, stderr, status: code });
			}
		});
	});
}

// ─── xml patcher ─────────────────────────────────────────────────────────────

/**
 * Replace the text content of one or more XML tags in a metadata file.
 * @param {string} filePath  Absolute path to the XML file.
 * @param {Record<string, string>} replacements  { tagName: newValue, … }
 */
function replaceXmlFields(filePath, replacements) {
	let xml = readFileSync(filePath, "utf8");
	for (const [tag, value] of Object.entries(replacements)) {
		const re = new RegExp(`(<${tag}>)[^<]*(</${tag}>)`, "g");
		xml = xml.replace(re, `$1${value}$2`);
	}
	writeFileSync(filePath, xml, "utf8");
}

// ─── site publish ────────────────────────────────────────────────────────────

function publishSite(siteName) {
	const result = runStep({ label: "publish site", command: `sf community publish --name "${siteName}" --json > etLogs/SH_publish-site.json`, failsAcepted: false });

	const stdout = result.stdout ?? "";
	const firstBrace = stdout.indexOf("{");
	const lastBrace = stdout.lastIndexOf("}");
	if (firstBrace === -1 || lastBrace === -1) {
		throw new Error(`sf community publish produced no JSON.\nstdout:\n${stdout}`);
	}

	let parsed;
	try {
		parsed = JSON.parse(stdout.slice(firstBrace, lastBrace + 1));
	} catch (err) {
		throw new Error(`Could not parse sf JSON: ${err.message}`);
	}

	if (!parsed.result?.url) {
		throw new Error(`sf community publish returned no URL:\n${JSON.stringify(parsed, null, 2)}`);
	}

	return parsed.result.url;
}

async function resolveFinalUrl(url) {
	const response = await fetch(url, { redirect: "follow" });
	return response.url;
}

// ─── main ────────────────────────────────────────────────────────────────────

async function testAnimation() {
	console.log("\n   Spinner test — press any key to stop.\n");
	const stopSpinner = startSpinner("Deploying");

	await new Promise((resolve) => {
		process.stdin.setRawMode(true);
		process.stdin.resume();
		process.stdin.once("data", resolve);
	});

	stopSpinner();
	process.stdin.setRawMode(false);
	process.stdin.pause();
	console.log("   ✓ Animation test complete\n");
}

async function main() {
	if (process.argv.includes("--animation")) {
		return testAnimation();
	}

	console.log("");
	console.log("╔══════════════════════════════════════╗");
	console.log("║   Headless360 — Exercise 0 Setup     ║");
	console.log("╚══════════════════════════════════════╝");
	console.log("");

	// ── Resolve current org username and stamp it into site metadata ───────────
	console.log("🔧 [0/5] Patching site metadata with current org username...");
	const orgDisplayResult = runStep({ label: "org display", command: `sf org display --json`, failsAcepted: false });
	const orgInfo = JSON.parse(orgDisplayResult.stdout);
	const orgUsername = orgInfo.result.username;
	replaceXmlFields(
		join(ROOT, "../", "force-site/main/default/sites/Headless360_Portal.site-meta.xml"),
		{
			siteAdmin: orgUsername,
			siteGuestRecordDefaultOwner: orgUsername,
		}
	);
	console.log(`   ✓ Patched siteAdmin + siteGuestRecordDefaultOwner → ${orgUsername}\n`);

	console.log("🚀 [1/5] Deploying metadata (core and site)...");
	// Agentforce vibes can't open a tab, so just display the URL and ask the user to open it themselves if they want to watch the deployment status. The deploy command will still run and fail if there are issues, so it's not a problem to skip this step.
	// runStep({ label: "open deploy status", command: `sf org open --path="/lightning/setup/DeployStatus/home" --url-only`, failsAcepted: false });
	// await runStepAnimated({ label: "deploy metadata", command: `sf project deploy start --ignore-conflicts --verbose --json > etLogs/SH_deploy-metadata.json`, animLabel: "Deploying", failsAcepted: false });
	runStepPassthrough({ label: "deploy metadata", command: `sf project deploy start --ignore-conflicts --verbose`, failsAcepted: false });
	console.log("   ✓ Metadata deployed\n");

	console.log("🌐 [2/5] Assigning permission set...");
	runStep({ label: "assign permset", command: `sf org assign permset --name="ET_TODO_Admin" --json > etLogs/SH_assign-permset.json`, failsAcepted: true });
	console.log("   ✓ Permission set assigned\n");

	console.log("🌱 [3/5] Seeding data (15 accounts, 61 contacts, ~610 TODOs, 61 cases)...");
	console.log("   Inserting accounts and contacts...");
	runStep({ label: "seed accounts/contacts", command: `sf apex run --file @ELTOROit/scripts/seed-accounts-contacts.apex > etLogs/SH_seed-accounts-contacts.json`, failsAcepted: false });
	console.log("   Inserting TODOs...");
	runStep({ label: "seed TODOs", command: `sf apex run --file @ELTOROit/scripts/seed-todos.apex > etLogs/SH_seed-todos.json`, failsAcepted: false });
	console.log("   Inserting cases...");
	runStep({ label: "seed cases", command: `sf apex run --file @ELTOROit/scripts/seed-cases.apex > etLogs/SH_seed-cases.json`, failsAcepted: false });
	console.log("   ✓ Data seeded\n");

	console.log("🔑 [4/5] Granting guest user permissions...");
	runStep({ label: "grant guest permissions", command: `sf apex run --file @ELTOROit/scripts/grant-guest-permissions.apex > etLogs/SH_grant-guest-permissions.json`, failsAcepted: false });
	console.log("   ✓ Guest permissions assigned\n");

	console.log("📢 [5/5] Publishing LWR site...");
	const publishUrl = publishSite("Headless360 Portal");
	const finalUrl = await resolveFinalUrl(publishUrl);
	console.log("   ✓ Site published\n");

	console.log("Open the URL above in your browser and you are ready to go.");
	console.log(`\n   ${finalUrl}\n`);
}

main().catch(async (err) => {
	console.error("\n❌ Setup failed:");
	await pageOutput(err.message);
	process.exit(1);
});
