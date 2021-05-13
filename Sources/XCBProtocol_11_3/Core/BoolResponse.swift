import Foundation
import MessagePack
import XCBProtocol

public struct BoolResponse {
    public let value: Bool
    
    public init(_ value: Bool) {
        self.value = value
    }
}

// MARK: - ResponsePayloadConvertible

extension BoolResponse: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .bool(self) }
}

// MARK: - Decoding

extension BoolResponse: Decodable {}

// MARK: - Encoding

extension BoolResponse: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [.bool(value)]
    }
}
