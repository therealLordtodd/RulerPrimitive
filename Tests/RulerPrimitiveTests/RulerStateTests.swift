import Foundation
import Testing
@testable import RulerPrimitive

@MainActor
@Suite("RulerState Tests")
struct RulerStateTests {
    @Test func addAndRemoveMarker() {
        let state = RulerState()
        let marker = RulerMarkerItem(position: 72, markerType: .leftMargin)
        state.addMarker(marker)
        #expect(state.markers.count == 1)
        state.removeMarker(id: marker.id)
        #expect(state.markers.isEmpty)
    }

    @Test func moveMarker() {
        let state = RulerState()
        let marker = RulerMarkerItem(position: 72, markerType: .leftMargin)
        state.addMarker(marker)
        state.moveMarker(id: marker.id, to: 100)
        #expect(state.markers[0].position == 100)
    }

    @Test func moveNonDraggableMarkerDoesNothing() {
        let state = RulerState()
        let marker = RulerMarkerItem(position: 72, markerType: .leftMargin, isDraggable: false)
        state.addMarker(marker)
        state.moveMarker(id: marker.id, to: 100)
        #expect(state.markers[0].position == 72)
    }

    @Test func tabStopsSortedByPosition() {
        let state = RulerState()
        state.addMarker(RulerMarkerItem(position: 200, markerType: .tabStop(.right)))
        state.addMarker(RulerMarkerItem(position: 100, markerType: .tabStop(.left)))
        state.addMarker(RulerMarkerItem(position: 72, markerType: .leftMargin))

        let tabs = state.tabStops
        #expect(tabs.count == 2)
        #expect(tabs[0].position == 100)
        #expect(tabs[1].position == 200)
    }

    @Test func removeActiveMarkerClearsSelection() {
        let state = RulerState()
        let marker = RulerMarkerItem(position: 72, markerType: .leftMargin)
        state.addMarker(marker)
        state.activeMarkerID = marker.id
        state.removeMarker(id: marker.id)
        #expect(state.activeMarkerID == nil)
    }
}
