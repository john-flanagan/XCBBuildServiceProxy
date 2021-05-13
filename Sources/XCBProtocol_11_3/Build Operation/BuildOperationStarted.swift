import Foundation
import MessagePack
import XCBProtocol

public struct BuildOperationStarted {
    public let buildNumber: Int64
    
    public init(buildNumber: Int64) {
        self.buildNumber = buildNumber
    }
}

// MARK: - ResponsePayloadConvertible

extension BuildOperationStarted: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .buildOperationStarted(self) }
}

// MARK: - Decoding

extension BuildOperationStarted: Decodable {}

// MARK: - Encoding

extension BuildOperationStarted: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [.int64(buildNumber)]
    }
}
