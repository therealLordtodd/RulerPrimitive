import Foundation
import Testing
@testable import RulerPrimitive

@Suite("RulerPrimitive Model Tests")
struct ModelTests {
    @Test func rulerUnitConversion() {
        #expect(RulerUnit.inches.pointsPerUnit == 72)
        #expect(RulerUnit.points.pointsPerUnit == 1)
        #expect(RulerUnit.picas.pointsPerUnit == 12)
    }

    @Test func configurationPointsToUnit() {
        let config = RulerConfiguration(unit: .inches, origin: 0, length: 612)
        #expect(config.pointsToUnit(72) == 1)
        #expect(config.pointsToUnit(144) == 2)
        #expect(config.pointsToUnit(0) == 0)
    }

    @Test func configurationUnitToPoints() {
        let config = RulerConfiguration(unit: .inches, origin: 0, length: 612)
        #expect(config.unitToPoints(1) == 72)
        #expect(config.unitToPoints(2) == 144)
    }

    @Test func configurationWithOriginOffset() {
        let config = RulerConfiguration(unit: .inches, origin: 72, length: 468)
        #expect(config.pointsToUnit(144) == 1)
    }

    @Test func configurationCodableRoundTrip() throws {
        let config = RulerConfiguration(unit: .centimeters, origin: 10, length: 500, subdivisions: 10)
        let data = try JSONEncoder().encode(config)
        let decoded = try JSONDecoder().decode(RulerConfiguration.self, from: data)
        #expect(decoded == config)
    }

    @Test func markerItemCreation() {
        let marker = RulerMarkerItem(position: 72, markerType: .leftMargin)
        #expect(marker.position == 72)
        #expect(marker.isDraggable == true)
        #expect(marker.markerType == .leftMargin)
    }

    @Test func tabStopMarkerType() {
        let marker = RulerMarkerItem(position: 144, markerType: .tabStop(.center))
        if case .tabStop(let alignment) = marker.markerType {
            #expect(alignment == .center)
        } else {
            #expect(Bool(false), "Expected tabStop marker type")
        }
    }
}
