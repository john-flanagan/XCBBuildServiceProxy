import Foundation
import MessagePack
import XCBProtocol

public struct BuildCancelRequest {
    public let sessionHandle: String
    public let buildNumber: Int64
}

// MARK: - Decoding

extension BuildCancelRequest: Decodable {}
