import Foundation
import MessagePack
import XCBProtocol

public struct BuildOperationTargetEnded {
    public let targetID: Int64
    
    public init(targetID: Int64) {
        self.targetID = targetID
    }
}

// MARK: - ResponsePayloadConvertible

extension BuildOperationTargetEnded: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .buildOperationTargetEnded(self) }
}

// MARK: - Decoding

extension BuildOperationTargetEnded: Decodable {}

// MARK: - Encoding

extension BuildOperationTargetEnded: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [.int64(targetID)]
    }
}
