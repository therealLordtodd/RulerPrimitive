# RulerPrimitive

RulerPrimitive provides ruler measurement and marker state for word-processor style editing surfaces.

## Quick Start

```swift
import RulerPrimitive

let configuration = RulerConfiguration(unit: .inch, origin: 0, length: 612)
let state = RulerState(configuration: configuration)

state.addMarker(
    RulerMarkerItem(position: 72, markerType: .tab(.left))
)

let inches = configuration.pointsToUnit(72)
```

## Key Types
- `RulerConfiguration`: Unit, origin, length, subdivisions, and point/unit conversions.
- `RulerUnit`: Inches, centimeters, millimeters, picas, and points.
- `RulerMarkerItem`: Identifiable marker with point position, marker type, and drag flag.
- `RulerMarkerType`: Margins, indents, and tab stops.
- `RulerState`: Observable marker collection with add, remove, move, lookup, and tab stop helpers.

## Common Operations
- Use `unitToPoints(_:)` and `pointsToUnit(_:)` at UI boundaries.
- Use `RulerState.moveMarker(id:to:)` for drag updates.
- Use `RulerState.tabStops` when applying paragraph tab behavior.

## Testing

Run:

```bash
swift test
```
