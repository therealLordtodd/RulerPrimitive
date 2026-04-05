import CoreGraphics
import Foundation

public enum RulerUnit: String, Codable, Sendable, CaseIterable {
    case inches
    case centimeters
    case points
    case picas

    public var pointsPerUnit: CGFloat {
        switch self {
        case .inches: 72
        case .centimeters: 28.3465
        case .points: 1
        case .picas: 12
        }
    }

    public var abbreviation: String {
        switch self {
        case .inches: "in"
        case .centimeters: "cm"
        case .points: "pt"
        case .picas: "pc"
        }
    }
}

public enum TabAlignment: String, Codable, Sendable, CaseIterable {
    case left
    case center
    case right
    case decimal
}

public struct RulerConfiguration: Codable, Sendable, Equatable {
    public var unit: RulerUnit
    public var origin: CGFloat
    public var length: CGFloat
    public var subdivisions: Int

    public init(
        unit: RulerUnit = .inches,
        origin: CGFloat = 0,
        length: CGFloat = 612,
        subdivisions: Int = 8
    ) {
        self.unit = unit
        self.origin = origin
        self.length = length
        self.subdivisions = max(1, subdivisions)
    }

    public func pointsToUnit(_ points: CGFloat) -> CGFloat {
        (points - origin) / unit.pointsPerUnit
    }

    public func unitToPoints(_ value: CGFloat) -> CGFloat {
        (value * unit.pointsPerUnit) + origin
    }
}
