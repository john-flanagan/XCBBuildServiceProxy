import Foundation
import MessagePack
import XCBProtocol

public struct SessionCreated {
    public let sessionHandle: String
    public let unknown: MessagePackValue
    
    public init(sessionHandle: String) {
        self.sessionHandle = sessionHandle
        self.unknown = .array([])
    }
}

// MARK: - ResponsePayloadConvertible

extension SessionCreated: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .sessionCreated(self) }
}

// MARK: - Decoding

extension SessionCreated: Decodable {}

// MARK: - Encoding

extension SessionCreated: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [
            .string(sessionHandle),
            unknown,
        ]
    }
}
