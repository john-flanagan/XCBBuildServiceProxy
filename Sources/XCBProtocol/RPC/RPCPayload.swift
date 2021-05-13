import Foundation
import MessagePack

// swiftformat:disable braces
// swiftlint:disable opening_brace

public protocol RequestPayload: Decodable {
    static func unknownRequest(values: [MessagePackValue]) -> Self
    
    /// - Returns: the Xcode path in the `CREATE_SESSION` message, or `nil` if it's another message.
    var createSessionXcodePath: String? { get }
}

public protocol ResponsePayload: Decodable, EncodableRPCPayload {
    static func unknownResponse(values: [MessagePackValue]) -> Self
    static func errorResponse(_ message: String) -> Self
}

public protocol ResponsePayloadConvertible {
    associatedtype Payload: ResponsePayload
    
    func toResponsePayload() -> Payload
}

extension RPCResponse {
    public init<PayloadConvertible>(channel: UInt64, payloadConvertible: PayloadConvertible) where
        PayloadConvertible: ResponsePayloadConvertible,
        PayloadConvertible.Payload == Payload
    {
        self.init(channel: channel, payload: payloadConvertible.toResponsePayload())
    }
}

// MARK: - Encoding/Decoding

// TODO: Replace with Encodable
public protocol EncodableRPCPayload: CustomEncodableRPCPayload {
    func encode() -> [MessagePackValue]
}

public protocol CustomEncodableRPCPayload {
    func encode() -> MessagePackValue
}

public extension EncodableRPCPayload {
    func encode() -> MessagePackValue {
        return .array(encode())
    }
}

public enum RPCPayloadDecodingError: Error {
    case invalidCount(_ count: Int, indexPath: IndexPath)
    case indexOutOfBounds(indexPath: IndexPath)
    case incorrectValueType(indexPath: IndexPath, expectedType: Any.Type)
    case missingValue(indexPath: IndexPath)
}
