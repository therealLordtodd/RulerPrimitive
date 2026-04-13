# RulerPrimitive

`RulerPrimitive` is a small model package for word-processor-style ruler state. It handles units, marker positions, tab stops, and observable ruler state so host apps can build their own ruler UI without redoing the underlying measurement logic.

It is intentionally rendering-agnostic. It does not ship a ruler view.

## When To Use It

Use `RulerPrimitive` when you want:

- paragraph indents, tab stops, and margin markers represented as structured data
- unit conversion between points and display units like inches or centimeters
- a shared ruler state model used by inspectors, editors, and layout code

Do not use it if your app only needs one fixed margin value and no real ruler interaction.

## What Ships

The public surface is small and clean:

- `RulerUnit` and `TabAlignment`
- `RulerConfiguration` for unit conversion and ruler extent
- `RulerMarkerType` and `RulerMarkerItem`
- `RulerState` as the observable container for markers and selection

## Core Types

| Type | What it does |
| --- | --- |
| `RulerUnit` | Supported display units: inches, centimeters, points, and picas |
| `TabAlignment` | Tab-stop alignment: left, center, right, or decimal |
| `RulerConfiguration` | Stores unit, origin, length, subdivisions, and conversion helpers |
| `RulerMarkerType` | Describes the meaning of a marker |
| `RulerMarkerItem` | One marker with a point position and draggable flag |
| `RulerState` | Observable state object containing configuration, markers, and active marker selection |

## Examples

### 1. Configure a ruler and convert units

```swift
import RulerPrimitive

let configuration = RulerConfiguration(
    unit: .inches,
    origin: 0,
    length: 612,
    subdivisions: 8
)

let oneInch = configuration.pointsToUnit(72)
let twoAndAHalfInches = configuration.unitToPoints(2.5)
```

This is the basic bridge between document points and the units your UI shows to users.

### 2. Create ruler state for an editor

```swift
import RulerPrimitive

let state = RulerState(configuration: configuration)

state.addMarker(RulerMarkerItem(position: 72, markerType: .leftMargin))
state.addMarker(RulerMarkerItem(position: 540, markerType: .rightMargin))
state.addMarker(RulerMarkerItem(position: 108, markerType: .firstLineIndent))
state.addMarker(RulerMarkerItem(position: 144, markerType: .hangingIndent))
```

This is a good fit for a page-oriented editor or inspector.

### 3. Work with tab stops

```swift
state.addMarker(RulerMarkerItem(position: 180, markerType: .tabStop(.left)))
state.addMarker(RulerMarkerItem(position: 320, markerType: .tabStop(.center)))
state.addMarker(RulerMarkerItem(position: 420, markerType: .tabStop(.decimal)))

let tabs = state.tabStops
```

`tabStops` gives you a sorted subset you can feed into paragraph layout code.

### 4. Move or select a marker

```swift
let marker = RulerMarkerItem(position: 72, markerType: .leftMargin)
state.addMarker(marker)

state.activeMarkerID = marker.id
state.moveMarker(id: marker.id, to: 96)
```

Your UI can bind to `activeMarkerID` during drag interactions or inspector edits.

### 5. Use fixed, non-draggable guides

```swift
let guide = RulerMarkerItem(
    position: 306,
    markerType: .columnGuide,
    isDraggable: false
)

state.addMarker(guide)
state.moveMarker(id: guide.id, to: 360) // ignored
```

This is useful for layout guides that should display but not be directly editable.

## Wiring It Into Your App

The clean host-app pattern is:

1. Keep marker positions in points.
2. Use `RulerConfiguration` only for display and input conversion.
3. Render your own ruler UI from `RulerState.markers`.
4. Feed marker changes back into paragraph, page, or layout state elsewhere in the app.

That separation matters. The package is strong precisely because it does not try to own both the model and the view layer.

Practical guidance:

- store document semantics in your editor model, not only in ruler state
- use `RulerState` as the interaction-facing projection of that model
- persist `RulerConfiguration` and `RulerMarkerItem` values directly when your app supports document restore
- use `tabStops` when paragraph layout wants only tab markers and not margins or guides

## Constraints And Notes

- `RulerPrimitive` does not ship SwiftUI or AppKit ruler controls.
- Marker positions are stored in points, regardless of display unit.
- `moveMarker` silently ignores attempts to move non-draggable markers.
- The package is a good fit underneath document editors, inspectors, and print-layout tools.

## Platform Support

- macOS 15+
- iOS 17+
