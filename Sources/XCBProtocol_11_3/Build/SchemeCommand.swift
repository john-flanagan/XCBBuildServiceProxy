import Foundation
import MessagePack
import XCBProtocol

public enum SchemeCommand: Int64 {
    case launch
    case test
    case profile
    case archive
}

// MARK: - Decoding

extension SchemeCommand: Decodable {}
