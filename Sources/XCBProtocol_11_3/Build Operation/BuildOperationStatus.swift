import Foundation
import MessagePack
import XCBProtocol

public enum BuildOperationStatus: Int64 {
    case succeeded
    case cancelled
    case failed
}

// MARK: - Decoding

extension BuildOperationStatus: Decodable {}
