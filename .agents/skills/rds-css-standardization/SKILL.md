---
name: rds-css-standardization
description: Use when refactoring, cleaning up, or styling Vue/Nuxt pages and components to align with ASU's Responsive Design System (RDS), standard utility classes, and CSS naming conventions.
---

# RDS CSS Standardization Skill

Use for CSS cleanup in the target Nuxt/Vue package. Optimize for RDS/Bootstrap utilities in Vue templates, scoped CSS only where utilities cannot express the behavior.

## Source Of Truth

- Theme import: `<target-package>/nuxt.config.ts` should include `@rds-vue-ui/rds-theme-base/dist/css/rds-theme-base.css`.
- Local package: `<target-package>/node_modules/@rds-vue-ui/rds-theme-base`.
- Compiled classes: `dist/css/rds-theme-base.css`.
- Token/source files: `style/_colors.scss`, `style/_spacing-vars.scss`, `style/_variables.scss`, `style/_typography.scss`, `style/_main.scss`.

If a utility is uncertain, verify it locally before using it:

```sh
rg -n "@rds-vue-ui/rds-theme-base/dist/css/rds-theme-base.css" <target-package>/nuxt.config.ts
rg -n "\\.(gap-space-lg|text-dark-3|btn-primary)\\b" <target-package>/node_modules/@rds-vue-ui/rds-theme-base/dist/css/rds-theme-base.css
rg -n "space-|theme-colors|font-sizes|h1-small" <target-package>/node_modules/@rds-vue-ui/rds-theme-base/style -S
```

Read `references/rds-utilities.md` only for broad conversions or when local CSS lookup needs category guidance.

## Rules

1. Move utility-equivalent CSS to the Vue tag's `class` attribute.
2. Keep scoped CSS for dimensions, grid templates, complex gradients/shadows, pseudo-elements, animation, custom states, accessibility/focus rules, and responsive one-offs not covered by utilities.
3. Use `var(--rds-*)` tokens for remaining custom CSS. Avoid raw hex colors unless matching a non-RDS asset or unavoidable visual spec.
4. Ban static inline styles. Allow dynamic Vue `:style` only for data-driven values, such as chart bar width/height, when no utility can represent the value.
5. Use `<style scoped>` or `<style scoped lang="scss">` in Vue SFCs unless editing an intentional global stylesheet.
6. Use component/page-prefixed BEM hooks for custom selectors. Avoid generic custom root classes like `.container`, `.left`, `.right`, `.card`, `.content`, `.header`, `.footer`.

## Conversion Workflow

1. Inventory the touched Vue file for `style=`, raw hex/rgba, custom CSS variables, and utility-convertible declarations.
2. Check these high-miss properties first: `display`, `gap`, `row-gap`, `column-gap`, `margin`, `padding`, `color`, `background`, `border`, `border-radius`, `font-size`, `font-weight`, `line-height`, `text-align`, `justify-content`, `align-items`, `width`, `height`, `position`, `overflow`.
3. Map direct equivalents to utilities. Prefer responsive utilities such as `d-md-flex`, `gap-lg-space-md`, `px-sm-gutter` over media-query overrides when behavior matches.
4. Keep semantic BEM classes only when custom CSS remains or they improve readability/testing.
5. Remove dead CSS after extraction.

## Utility Families

RDS theme base includes Bootstrap 5.3 utilities plus ASU palette and spacing extensions. Common families:

- Color/background: `text-*`, `bg-*`, `text-bg-*`, `*-subtle`, opacity helpers.
- Spacing/gaps: `m*`, `p*`, `gap-*`, `row-gap-*`, `column-gap-*`, `g-*`, `gx-*`, `gy-*`; sizes include `0`, `auto`, `gutter`, `space-xxxs` through `space-xxxl`, and negative margin `nspace-*`.
- Layout: `d-*`, responsive display, `flex-*`, `align-*`, `justify-*`, `container*`, `row`, `col*`, `w-*`, `h-*`, `position-*`, `overflow-*`.
- Typography: `h1-*`, `h2-*`, `h3-*`, `fs-*`, `fw-*`, `lh-*`, text alignment/wrap/transform/decoration.
- Surface/components: `border*`, `rounded*`, `shadow*`, `btn*`, `card*`, `form*`, `list-group*`, `rds-list*`, `rds-link`.

## Miss Prevention

Before finishing:

- Search touched Vue files for static `style="`, raw hex colors, and `rgba(...)` values that can use `var(--rds-*-rgb)`.
- Search scoped CSS for the high-miss properties above.
- For every custom declaration left behind, confirm one reason: no utility exists, value is dynamic, selector is semantic, or behavior is too specific.
- Verify non-obvious utility classes against local `rds-theme-base.css`.
