// ─────────────────────────────────────────────────────────────────────────────
// box-model-diagram.typ
// Standalone CSS box model diagram using Typst's native drawing primitives.
// No external packages required.
// Include in any lesson file with: #include "box-model-diagram.typ"
// ─────────────────────────────────────────────────────────────────────────────

#{
  let c-margin  = rgb("#D6E8F5")
  let c-border  = rgb("#F5C842")
  let c-padding = rgb("#B8DDB8")
  let c-content = rgb("#E8E8E8")

  let total-w = 340pt
  let total-h = 260pt
  let margin-inset  = 28pt
  let border-size   = 10pt
  let padding-inset = 28pt

  let border-x = margin-inset
  let border-y = margin-inset
  let border-w = total-w - 2 * margin-inset
  let border-h = total-h - 2 * margin-inset
  let padding-x = border-x + border-size
  let padding-y = border-y + border-size
  let padding-w = border-w - 2 * border-size
  let padding-h = border-h - 2 * border-size
  let content-x = padding-x + padding-inset
  let content-y = padding-y + padding-inset
  let content-w = padding-w - 2 * padding-inset
  let content-h = padding-h - 2 * padding-inset

  align(center,
    figure(
      block(width: total-w, height: total-h, {
        // Layer rectangles
        place(top + left,
          rect(width: total-w, height: total-h,
            fill: c-margin, stroke: none, radius: 3pt))
        place(top + left, dx: border-x, dy: border-y,
          rect(width: border-w, height: border-h,
            fill: c-border, stroke: none))
        place(top + left, dx: padding-x, dy: padding-y,
          rect(width: padding-w, height: padding-h,
            fill: c-padding, stroke: none))
        place(top + left, dx: content-x, dy: content-y,
          rect(width: content-w, height: content-h,
            fill: c-content, stroke: none, radius: 2pt))
        // Content label
        place(top + left, dx: content-x, dy: content-y,
          block(width: content-w, height: content-h,
            align(center + horizon,
              stack(spacing: 4pt,
                text(size: 10pt, weight: "bold",
                  fill: rgb("#444444"))[Content],
                text(size: 8pt,
                  fill: rgb("#888888"))[text, image, etc.],
              )
            )
          )
        )
        // Top labels
        place(top + left, dx: 0pt, dy: 0pt,
          block(width: total-w, height: margin-inset,
            align(center + horizon,
              text(size: 9pt, weight: "bold",
                fill: rgb("#1A4A6E"))[margin])))
        place(top + left, dx: border-x, dy: border-y,
          block(width: border-w, height: border-size,
            align(center + horizon,
              text(size: 7.5pt, weight: "bold",
                fill: rgb("#7A5A00"))[border])))
        place(top + left, dx: padding-x, dy: padding-y,
          block(width: padding-w, height: padding-inset,
            align(center + horizon,
              text(size: 9pt, weight: "bold",
                fill: rgb("#2E5E2E"))[padding])))
        // Left-side labels
        place(top + left, dx: 0pt, dy: margin-inset,
          block(width: margin-inset,
            height: total-h - 2 * margin-inset,
            align(center + horizon,
              rotate(-90deg,
                text(size: 9pt, weight: "bold",
                  fill: rgb("#1A4A6E"))[margin]))))
        place(top + left, dx: border-x,
          dy: border-y + border-size,
          block(width: border-size,
            height: border-h - 2 * border-size,
            align(center + horizon,
              rotate(-90deg,
                text(size: 7pt, weight: "bold",
                  fill: rgb("#7A5A00"))[border]))))
        place(top + left, dx: padding-x,
          dy: padding-y + padding-inset,
          block(width: padding-inset,
            height: padding-h - 2 * padding-inset,
            align(center + horizon,
              rotate(-90deg,
                text(size: 9pt, weight: "bold",
                  fill: rgb("#2E5E2E"))[padding]))))
      }),
      caption: [The CSS box model — every HTML element is surrounded by
        padding, border, and margin.],
    )
  )
}
