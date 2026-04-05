import Foundation
import Observation

@MainActor
@Observable
public final class RulerState {
    public var configuration: RulerConfiguration
    public var markers: [RulerMarkerItem]
    public var activeMarkerID: UUID?

    public init(
        configuration: RulerConfiguration = RulerConfiguration(),
        markers: [RulerMarkerItem] = []
    ) {
        self.configuration = configuration
        self.markers = markers
    }

    public func addMarker(_ marker: RulerMarkerItem) {
        markers.append(marker)
    }

    public func removeMarker(id: UUID) {
        markers.removeAll { $0.id == id }
        if activeMarkerID == id {
            activeMarkerID = nil
        }
    }

    public func moveMarker(id: UUID, to position: CGFloat) {
        guard let index = markers.firstIndex(where: { $0.id == id }),
              markers[index].isDraggable
        else {
            return
        }

        markers[index].position = position
    }

    public func marker(at id: UUID) -> RulerMarkerItem? {
        markers.first { $0.id == id }
    }

    public var tabStops: [RulerMarkerItem] {
        markers.filter {
            if case .tabStop = $0.markerType {
                return true
            }
            return false
        }
        .sorted { $0.position < $1.position }
    }
}
