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
