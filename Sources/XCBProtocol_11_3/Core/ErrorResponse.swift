import Foundation
import MessagePack
import XCBProtocol

public struct ErrorResponse {
    public let message: String
    
    public init(_ message: String) {
        self.message = message
    }
}

// MARK: - ResponsePayloadConvertible

extension ErrorResponse: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .error(self) }
}

// MARK: - Decoding

extension ErrorResponse: Decodable {}

// MARK: - Encoding

extension ErrorResponse: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [.string(message)]
    }
}
