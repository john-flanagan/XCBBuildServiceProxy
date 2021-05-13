import Foundation
import MessagePack
import XCBProtocol

public enum BuildOperationDiagnosticKind: Int64 {
    case info
    case warning
    case error
}

// MARK: - Decoding

extension BuildOperationDiagnosticKind: Decodable {}
