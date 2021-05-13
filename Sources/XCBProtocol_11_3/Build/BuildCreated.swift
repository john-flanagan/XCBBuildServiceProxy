import Foundation
import MessagePack
import XCBProtocol

public struct BuildCreated {
    public let buildNumber: Int64
    
    public init(buildNumber: Int64) {
        self.buildNumber = buildNumber
    }
}

// MARK: - ResponsePayloadConvertible

extension BuildCreated: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .buildCreated(self) }
}

// MARK: - Decoding

extension BuildCreated: Decodable {}

// MARK: - Encoding

extension BuildCreated: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [
            .int64(buildNumber),
        ]
    }
}
