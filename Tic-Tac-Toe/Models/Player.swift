struct Player: Equatable, Hashable {
    let name: String
    let marker: Marker

    var isO: Bool {
        marker == .o
    }

    var isX: Bool {
        marker == .x
    }
}
