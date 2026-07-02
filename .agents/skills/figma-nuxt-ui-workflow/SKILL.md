---
name: figma-nuxt-ui-workflow
description: Use when implementing, recreating, inspecting, or updating Nuxt/Vue UI from Figma links, screenshots, selected frames, design-system references, or Figma node IDs. Combines Figma screen discovery, Nuxt 4 implementation guidance, responsive design fidelity, optional ASU RDS CSS standardization, Code Connect/Figma MCP extraction, and package-scoped validation.
---

# Figma Nuxt UI Workflow

Turn Figma context into maintainable Nuxt/Vue UI code. Inspect enough of the design and local app to avoid building the wrong screen, then implement with Nuxt conventions, responsive fidelity, and RDS-aware CSS only when the target package supports it.

## Routing

- Use this skill for Nuxt/Vue UI work from Figma files, frame/node links, screenshots, selected design nodes, or design-system references.
- Use it as the front door when the exact screen is unclear, and as the implementation workflow once the frame and target Nuxt package/file are known.
- For Jira-ticket-aware implementation requests, enforce `.agents/skills/aidlc-jira-ticket-workflow/SKILL.md` first; use this skill for the Figma/UI portion only after Jira intake and planning gates allow implementation.
- If the user message starts with `Using AI-DLC,` or an active AI-DLC state exists, follow the AI-DLC control plane before implementation.

## Required Inputs
- Prefer a Figma selection URL with `node-id` and a target package, route, page, component, or Vue file.
- If the Figma URL lacks `node-id`, call Figma metadata to list pages and screen-like frames before asking the user to choose.
- If the target location is missing, inspect Nuxt packages, routes, pages, and nearby components. Infer the target only when one path is clearly plausible.

## Figma Inspection

1. Parse `fileKey` from `/design/:fileKey/...`.
2. Parse `nodeId` from `node-id=X-Y` and convert it to `X:Y`.
3. If no node ID is provided, call Figma metadata on the file, identify pages, then inspect relevant page metadata.
4. Identify screen-like frames:
   - Top-level page frames.
   - Frames with desktop, tablet, or mobile dimensions.
   - Frames named like Dashboard, Tasks, Budget, Reports, Home, Settings, Modal, Drawer, or flow steps.
5. If multiple plausible screens exist, stop and ask which screens to build. Include frame names, node IDs, and sizes.
6. For each selected screen, fetch `get_design_context` and `get_screenshot`.
7. Try Code Connect, mappings, suggestions, design-system search, and component matches when available. If Code Connect is unavailable, empty, unsupported, or blocked by permissions, continue with normal Figma context and screenshots.

## Clarification Policy

Ask only when the answer changes the implementation materially:

- Which screen or frame to build when multiple frames exist.
- Whether selected frames should become routes, tabs, sections, or replacements for existing UI.
- Which target package/file to edit when multiple local targets are plausible.
- Whether missing Figma access, MCP rate limits, or missing node IDs block inspection.
- Whether Figma and existing app behavior conflict.

Do not ask about minor spacing, colors, copy, or responsive behavior when Figma and local conventions provide a reasonable default.

## Local Nuxt Inspection

Before editing, inspect the target package and nearby patterns:

- `package.json`, `nuxt.config.ts`, `app.vue`, routes/pages/components, shared SCSS, stores, composables, middleware, and existing UI primitives.
- Detect Nuxt 4 `app/` structure, `<script setup lang="ts">`, auto imports, Pinia, Iconify/unplugin icons, Nuxt UI, RDS theme base, Bootstrap-compatible utilities, custom CSS variables, and local component naming conventions.
- Use `@nuxt/ui` only when `@nuxt/ui` is installed in the target package or the user explicitly requests it.
- Do not introduce new icon libraries, state libraries, CSS frameworks, or global dependencies unless already used locally or explicitly requested.

## Implementation Rules

- Map Figma sections to existing routes, components, selectors, state, data fetching, and API behavior where practical.
- Preserve existing product behavior, route names, middleware, runtime config, stores, and `data-testid` hooks unless deliberately replacing them.
- Use Nuxt 4 and Vue conventions: `<script setup lang="ts">`, typed props/emits, auto imports, semantic HTML, labels, keyboard-accessible controls, and meaningful alt text.
- Prefer existing components, composables, stores, CSS variables, design-system classes, and local UI primitives before adding abstractions.
- Build repeated top bars, side navs, and layout scaffolds once for multi-screen work.
- Adapt absolute Figma positioning into maintainable responsive layout using grid, flex, `minmax`, dimension `clamp()` where appropriate, and stable aspect ratios.
- Use real assets exported or referenced from Figma when they are part of the design.
- Preserve usability over pixel-perfect copying when Figma omits responsive or accessibility details.

## CSS And RDS Pass

Run a CSS maintenance pass after implementation.

- Use scoped styles for local CSS. Name custom selectors with component/page-prefixed BEM hooks, such as `landing-page__main`.
- Avoid generic custom names like `container`, `content`, `left-column`, `right-column`, `auth-btn`, `main-content`, and `hero-content`.
- Keep custom CSS only for exact Figma/page-specific dimensions, fixed visual panels, shadows, gradients, grid templates, pseudo-elements, animation, child-component overrides, custom states, and responsive one-offs not covered by utilities.
- Ban static inline styles. Allow dynamic Vue `:style` only for data-driven values that utilities cannot represent.
- Use `:deep()` only for required child-component overrides.

Apply the RDS module only when the target package uses RDS or the user explicitly requests RDS alignment:

- Detect RDS by checking `package.json` for `@rds-vue-ui/rds-theme-base`, `nuxt.config.ts` for `@rds-vue-ui/rds-theme-base/dist/css/rds-theme-base.css`, and nearby Vue files for utilities like `gap-space-*`, `text-dark-*`, `btn`, or `container-lg`.
- Prefer RDS/Bootstrap utility classes for display, spacing, alignment, typography, color, borders, radius, shadows, forms, buttons, and cards when the utility exactly matches behavior.
- Use `var(--rds-*)` tokens for remaining custom CSS. Avoid raw hex colors unless matching a non-RDS asset or unavoidable visual spec.
- Read `references/rds-utilities.md` only for broad RDS conversions or when local CSS lookup needs category guidance.
- Verify non-obvious utilities against the local compiled RDS CSS before using them.

## Multi-Screen Build Pattern

When the user asks to build all or selected screens:

1. List all screen-like frames first.
2. Ask the user to choose screens unless they explicitly said "build all".
3. Decide whether selected screens map to routes, tabs, sections, replacements, or reusable component examples.
4. Implement shared layout once.
5. Implement selected screens incrementally.
6. Validate each major screen before moving to the next when the change is large.

## Failure Handling

- If Figma MCP is unavailable, say so and ask for screenshots or frame exports.
- If Figma MCP rate limits block inspection, report the limitation and continue only with already inspected metadata or user-provided screenshots/frame links.
- If Code Connect fails because the account lacks a Developer seat or Organization/Enterprise plan, use regular Figma metadata/design-context inspection.
- If a visual detail cannot be implemented safely, state the tradeoff and choose the maintainable option.

## Validation

- Run the narrowest package command that covers the change, usually `pnpm --filter <package-name> build`.
- If available and relevant, also run package-local typecheck, lint, tests, or syntax checks.
- Do not run broad workspace commands when targeted checks cover the edited package.
- For substantial visual work, start the relevant Nuxt dev server and inspect desktop and mobile widths in a browser.
- Compare against the Figma screenshot and iterate on spacing, typography, color, imagery, and responsive behavior.
- Before finishing, search touched Vue files for static `style="`, raw hex colors, `rgba(...)`, dead CSS, and custom declarations that could be utilities.

## Completion

Finish with:

- Screens inspected and selected.
- Files changed.
- RDS detection result and CSS pass summary when applicable.
- Checks run.
- Missing visual verification, Figma access limits, or assumptions.
