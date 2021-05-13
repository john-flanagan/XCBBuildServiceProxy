import Foundation
import MessagePack
import XCBProtocol

public struct BuildOperationTaskUpToDate {
    public let taskGUID: Data
    public let targetID: Int64
    public let unknown: MessagePackValue
}

// MARK: - ResponsePayloadConvertible

extension BuildOperationTaskUpToDate: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .buildOperationTaskUpToDate(self) }
}

// MARK: - Decoding

extension BuildOperationTaskUpToDate: Decodable {}

// MARK: - Encoding

extension BuildOperationTaskUpToDate: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [
            .binary(taskGUID),
            .int64(targetID),
            unknown,
        ]
    }
}
