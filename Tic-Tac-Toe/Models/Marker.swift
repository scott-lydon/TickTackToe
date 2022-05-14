import UIKit

enum Marker: String, Equatable, Hashable {
    case o, x

    var image: UIImage {
        return .init(named: self.rawValue)!
    }
}
