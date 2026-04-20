# RulerPrimitive — Document Editor Family Membership

This primitive is a member of the Document Editor primitive family. It defines rendering-agnostic ruler units, markers, tab stops, and ruler state for document editors.

## Conventions This Primitive Participates In

- [x] [shared-types](../CONVENTIONS/shared-types-convention.md) — defines ruler-axis types; shares coordinate conventions with PaginationPrimitive
- [ ] [typed-static-constants](../CONVENTIONS/typed-static-constants-convention.md) — not participating
- [x] [document-editor-family-membership](../CONVENTIONS/document-editor-family-membership.md)

## Shared Types This Primitive Defines

- **Ruler types** — ruler units, markers, tab stops, ruler state
- **Layout-coordinate types** — coupled with PaginationPrimitive via DocumentPrimitive's composition
- Consumed by: `DocumentPrimitive`, `RichTextEditorKit`

## Shared Types This Primitive Imports

- (none from the family — Foundation only)

## Siblings That Hard-Depend on This Primitive

- `DocumentPrimitive` — composes rulers with pagination
- `RichTextEditorKit` — re-exports ruler surface

## Ripple-Analysis Checklist Before Modifying Public API

1. **Coordinate-system changes are HIGH-RIPPLE** — couples with PaginationPrimitive via DocumentPrimitive. Breaking coordinate semantics requires coordinated change across the pair.
2. Changes to ruler units (points/inches/mm): affects inspector UI + tab-stop rendering in every consumer.
3. Tab-stop model changes: affects RichTextEditorKit's editing surface.
4. Consult [dependency audit §5](../docs/plans/2026-04-19-document-editor-dependency-audit.md).
5. Document ripple impact in the commit/PR.

## Scope of Membership

Applies to modifications of RulerPrimitive's own code. Consumers just importing for their own app are unaffected.
