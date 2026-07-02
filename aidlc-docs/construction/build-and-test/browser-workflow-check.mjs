import { chromium } from "/Applications/Codex.app/Contents/Resources/cua_node/lib/node_modules/playwright/index.mjs";

const pageUrl = "file:///Users/adi/Documents/testing/index.html";
const browser = await chromium.launch({ headless: true });
const results = [];

function record(name, pass, detail = "") {
  results.push({ name, pass, detail });
}

try {
  const page = await browser.newPage({ viewport: { width: 1280, height: 900 } });

  await page.goto(pageUrl);
  await page.evaluate(() => localStorage.clear());
  await page.reload();

  record("initial empty state", await page.getByTestId("empty-state").isVisible(), await page.getByTestId("feedback-count").textContent());

  await page.getByTestId("submit-button").click();
  record("rating required error", (await page.getByTestId("rating-error").textContent()).includes("Choose a rating"));
  record("message required error", (await page.getByTestId("message-error").textContent()).includes("Enter feedback"));

  await page.getByTestId("email-input").fill("bad-email");
  await page.locator("input[name='rating'][value='5']").check();
  await page.getByTestId("message-input").fill("Great tool.");
  await page.getByTestId("submit-button").click();
  record("invalid optional email error", (await page.getByTestId("email-error").textContent()).includes("valid email"));

  await page.getByTestId("email-input").fill("adi@example.com");
  await page.getByTestId("name-input").fill("Adi");
  await page.getByTestId("submit-button").click();
  record("valid submit success", (await page.getByTestId("status-message").textContent()).includes("Feedback saved"));
  record("one entry count", (await page.getByTestId("feedback-count").textContent()).trim() === "1 entry");
  record("entry rendered with message", (await page.getByTestId("feedback-list").textContent()).includes("Great tool."));

  await page.reload();
  record("persistence after refresh", (await page.getByTestId("feedback-count").textContent()).trim() === "1 entry");

  await page.getByTestId("message-input").fill("Second note");
  await page.locator("input[name='rating'][value='4']").check();
  await page.getByTestId("submit-button").click();
  const firstMessage = await page.locator("[data-testid='feedback-list'] .feedback-message").first().textContent();
  record("newest first ordering", firstMessage === "Second note", firstMessage ?? "");

  await page.locator("[data-testid='feedback-list'] button[data-action='delete']").first().click();
  record("individual delete", (await page.getByTestId("feedback-count").textContent()).trim() === "1 entry");

  await page.getByTestId("clear-all-button").click();
  record("clear all", (await page.getByTestId("feedback-count").textContent()).trim() === "0 entries");
  record("empty state returns", await page.getByTestId("empty-state").isVisible());

  await page.setViewportSize({ width: 390, height: 844 });
  await page.reload();
  const mobileOverflow = await page.evaluate(() => document.documentElement.scrollWidth > document.documentElement.clientWidth);
  record("mobile no horizontal overflow", !mobileOverflow, "scrollWidth check");

  await page.setViewportSize({ width: 1280, height: 900 });
  await page.reload();
  const desktopOverflow = await page.evaluate(() => document.documentElement.scrollWidth > document.documentElement.clientWidth);
  record("desktop no horizontal overflow", !desktopOverflow, "scrollWidth check");
} finally {
  await browser.close();
}

const failed = results.filter((result) => !result.pass);
console.log(JSON.stringify({ passed: failed.length === 0, results }, null, 2));
if (failed.length > 0) {
  process.exitCode = 1;
}
