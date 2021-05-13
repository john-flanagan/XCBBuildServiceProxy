import Foundation
import MessagePack
import XCBProtocol

public struct StringResponse {
    public let value: String
    
    public init(_ value: String) {
        self.value = value
    }
}

// MARK: - ResponsePayloadConvertible

extension StringResponse: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .string(self) }
}

// MARK: - Decoding

extension StringResponse: Decodable {}

// MARK: - Encoding

extension StringResponse: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [.string(value)]
    }
}
