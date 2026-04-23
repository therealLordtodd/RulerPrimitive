# RulerPrimitive Working Guide

## Purpose
RulerPrimitive models measurement units, ruler markers, tab stops, and ruler state for document editing UI. It deliberately owns state and conversion logic, not rendering.

## Key Directories
- `Sources/RulerPrimitive`: Unit configuration, marker models, and `RulerState`.
- `Tests/RulerPrimitiveTests`: Model and state mutation tests.

## Architecture Rules
- Keep the package rendering-agnostic. SwiftUI/AppKit/UIKit views should live in consumers.
- Store marker positions in points; use `RulerConfiguration` for unit conversion.
- Keep marker mutation observable through `RulerState` rather than scattering ruler arrays across callers.
- Preserve Codable model stability for saved editor preferences.

## Testing
- Run `swift test` before committing.
- Add state mutation coverage to `RulerStateTests`.
- Add unit conversion or Codable coverage to `ModelTests`.

---

## Family Membership — Document Editor

This primitive is a member of the Document Editor primitive family. It participates in shared conventions and consumes or publishes cross-primitive types used by the rich-text / document / editor stack.

**Before modifying public API, shared conventions, or cross-primitive types, consult:**
- `../RichTextEditorKit/docs/plans/2026-04-19-document-editor-dependency-audit.md` — who depends on whom, who uses which conventions
- `/Users/todd/Programming/Packages/CONVENTIONS/` — shared patterns this primitive participates in
- `./MEMBERSHIP.md` in this primitive's root — specific list of conventions, shared types, and sibling consumers

**Changes that alter public API, shared type definitions, or convention contracts MUST include a ripple-analysis section in the commit or PR description** identifying which siblings could be affected and how.

Standalone consumers (apps just importing this primitive) are unaffected by this discipline — it applies only to modifications to the primitive itself.
