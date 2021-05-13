import Foundation
import MessagePack
import XCBProtocol

public struct SDKVariant {
    public let rawValue: String
}

// MARK: - Decoding

extension SDKVariant: Decodable {}

extension SDKVariant: CustomStringConvertible {
    public var description: String { rawValue }
}

// MARK: - Encoding

extension SDKVariant: CustomEncodableRPCPayload {
    public func encode() -> MessagePackValue {
        return .string(rawValue)
    }
}
