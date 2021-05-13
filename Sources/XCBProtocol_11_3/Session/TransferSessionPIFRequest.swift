import Foundation
import MessagePack
import XCBProtocol

public struct TransferSessionPIFRequest {
    public let sessionHandle: String
    public let workspaceSignature: String
}

// MARK: - Decoding

extension TransferSessionPIFRequest: Decodable {}
