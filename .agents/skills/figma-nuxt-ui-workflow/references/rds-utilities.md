# RDS Utility Reference

Use this reference only when broad CSS conversion needs category guidance. Resolve the target Nuxt package first; that package's local compiled RDS CSS remains the source of truth:

`<target-package>/node_modules/@rds-vue-ui/rds-theme-base/dist/css/rds-theme-base.css`

## Colors And Backgrounds

- Text colors: `.text-white`, `.text-black`, `.text-body`, `.text-muted`, `.text-primary`, `.text-secondary`, `.text-success`, `.text-info`, `.text-warning`, `.text-danger`, `.text-light`, `.text-dark`, `.text-light-1` through `.text-light-5`, `.text-dark-1` through `.text-dark-3`.
- Text emphasis: `.text-primary-emphasis`, `.text-secondary-emphasis`, `.text-success-emphasis`, `.text-info-emphasis`, `.text-warning-emphasis`, `.text-danger-emphasis`, `.text-light-emphasis`, `.text-dark-emphasis`.
- Backgrounds: `.bg-white`, `.bg-black`, `.bg-transparent`, `.bg-body`, `.bg-primary`, `.bg-secondary`, `.bg-success`, `.bg-info`, `.bg-warning`, `.bg-danger`, `.bg-light`, `.bg-dark`, `.bg-light-1` through `.bg-light-5`, `.bg-dark-1` through `.bg-dark-3`.
- Subtle backgrounds: `.bg-primary-subtle`, `.bg-secondary-subtle`, `.bg-success-subtle`, `.bg-info-subtle`, `.bg-warning-subtle`, `.bg-danger-subtle`, `.bg-light-subtle`, `.bg-dark-subtle`.
- Combined helpers: `.text-bg-primary`, `.text-bg-secondary`, `.text-bg-success`, `.text-bg-info`, `.text-bg-warning`, `.text-bg-danger`, `.text-bg-light`, `.text-bg-dark`, `.text-bg-light-1` through `.text-bg-light-5`, `.text-bg-dark-1` through `.text-bg-dark-3`.
- Opacity: `.text-opacity-25`, `.text-opacity-50`, `.text-opacity-75`, `.text-opacity-100`, `.bg-opacity-10`, `.bg-opacity-25`, `.bg-opacity-50`, `.bg-opacity-75`, `.bg-opacity-100`.

## Spacing And Gaps

- Sizes: `0`, `auto` where applicable, `gutter`, `space-xxxs`, `space-xxs`, `space-xs`, `space-sm`, `space-md`, `space-lg`, `space-xl`, `space-xxl`, `space-xxxl`.
- Margin: `.m-*`, `.mt-*`, `.mb-*`, `.ms-*`, `.me-*`, `.mx-*`, `.my-*`.
- Padding: `.p-*`, `.pt-*`, `.pb-*`, `.ps-*`, `.pe-*`, `.px-*`, `.py-*`.
- Negative margin: `.m-nspace-*`, `.mt-nspace-*`, `.mb-nspace-*`, `.ms-nspace-*`, `.me-nspace-*`, `.mx-nspace-*`, `.my-nspace-*`, plus `ngutter`.
- Responsive spacing inserts breakpoint after property prefix: `.m-md-space-lg`, `.mt-lg-0`, `.mb-xl-space-sm`, `.px-sm-gutter`, `.p-xxl-space-xl`.
- Gaps: `.gap-*`, `.row-gap-*`, `.column-gap-*`, `.g-*`, `.gx-*`, `.gy-*`; examples include `.gap-md-space-lg`, `.row-gap-lg-space-sm`, `.column-gap-xl-gutter`, `.gx-lg-space-md`, `.gy-sm-0`.

## Layout And Sizing

- Display: `.d-none`, `.d-block`, `.d-inline`, `.d-inline-block`, `.d-flex`, `.d-inline-flex`, `.d-grid`, `.d-inline-grid`, `.d-table`, `.d-table-row`, `.d-table-cell`.
- Responsive display: `.d-sm-*`, `.d-md-*`, `.d-lg-*`, `.d-xl-*`, `.d-xxl-*`, plus print variants.
- Flex: `.flex-row`, `.flex-column`, `.flex-row-reverse`, `.flex-column-reverse`, `.flex-wrap`, `.flex-nowrap`, `.flex-wrap-reverse`, `.flex-fill`, `.flex-grow-0`, `.flex-grow-1`, `.flex-shrink-0`, `.flex-shrink-1`.
- Alignment: `.align-items-*`, `.align-content-*`, `.align-self-*`; justification: `.justify-content-*`.
- Grid: `.container*`, `.container-fluid`, `.row`, `.col`, `.col-auto`, `.col-1` through `.col-12`, and breakpoint columns such as `.col-md-6`.
- Sizing/position: `.w-25`, `.w-50`, `.w-75`, `.w-100`, `.w-auto`, `.h-25`, `.h-50`, `.h-75`, `.h-100`, `.h-auto`, `.position-*`, `.overflow-*`, `.overflow-x-*`, `.overflow-y-*`.

## Typography

- Headings: `.h1-small`, `.h1-medium`, `.h1-large`, `.h1-xl`, `.h2-small`, `.h2-medium`, `.h2-large`, `.h2-xl`, `.h3-small`, `.h3-medium`, `.h3-large`, `.h3-xl`, plus `.h1` through `.h6`.
- Body sizes: `.fs-xxl`, `.fs-xl`, `.fs-large`, `.fs-medium`, `.fs-small`, `.fs-xs`.
- Font weight: `.fw-lighter`, `.fw-light`, `.fw-normal`, `.fw-medium`, `.fw-semibold`, `.fw-bold`, `.fw-bolder`.
- Text: `.lh-*`, `.text-start`, `.text-center`, `.text-end`, responsive text alignment, `.text-wrap`, `.text-nowrap`, `.text-break`, `.text-truncate`, `.text-lowercase`, `.text-uppercase`, `.text-capitalize`, `.text-decoration-*`.

## Borders, Radius, Shadows, Components

- Borders: `.border`, `.border-0`, side variants, `.border-1` through `.border-5`, theme colors, `light-1` through `light-5`, `dark-1` through `dark-3`, subtle variants, and opacity helpers.
- Radius/shadow: `.rounded`, `.rounded-0` through `.rounded-5`, `.rounded-circle`, `.rounded-pill`, side-specific radius variants, `.shadow`, `.shadow-sm`, `.shadow-lg`, `.shadow-none`.
- Components: `.btn*`, `.card*`, `.form*`, `.list-group*`, `.rds-list*`, `.rds-link`, `.rds-tab`.
