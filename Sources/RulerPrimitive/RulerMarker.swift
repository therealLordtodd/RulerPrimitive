import CoreGraphics
import Foundation

public enum RulerMarkerType: Sendable, Equatable {
    case leftMargin
    case rightMargin
    case firstLineIndent
    case hangingIndent
    case tabStop(TabAlignment)
    case columnGuide
    case custom(String)
}

public struct RulerMarkerItem: Identifiable, Sendable, Equatable {
    public let id: UUID
    public var position: CGFloat
    public var markerType: RulerMarkerType
    public var isDraggable: Bool

    public init(
        id: UUID = UUID(),
        position: CGFloat,
        markerType: RulerMarkerType,
        isDraggable: Bool = true
    ) {
        self.id = id
        self.position = position
        self.markerType = markerType
        self.isDraggable = isDraggable
    }
}
