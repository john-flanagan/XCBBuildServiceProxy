import Foundation
import MessagePack
import XCBProtocol

public struct BuildOperationPreparationCompleted {
    public init() {}
}

// MARK: - ResponsePayloadConvertible

extension BuildOperationPreparationCompleted: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .buildOperationPreparationCompleted(self) }
}

// MARK: - Decoding

extension BuildOperationPreparationCompleted: Decodable {}

extension BuildOperationPreparationCompleted: CustomEncodableRPCPayload {
    public func encode() -> MessagePackValue {
        return .nil
    }
}
