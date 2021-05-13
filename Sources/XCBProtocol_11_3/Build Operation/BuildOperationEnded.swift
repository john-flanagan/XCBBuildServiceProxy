import Foundation
import MessagePack
import XCBProtocol

public struct BuildOperationEnded {
    public let buildNumber: Int64
    public let status: BuildOperationStatus
    public let unknown: MessagePackValue // This might be metrics?
    
    public init(buildNumber: Int64, status: BuildOperationStatus) {
        self.buildNumber = buildNumber
        self.status = status
        self.unknown = .nil
    }
}

// MARK: - ResponsePayloadConvertible

extension BuildOperationEnded: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .buildOperationEnded(self) }
}

// MARK: - Decoding

extension BuildOperationEnded: Decodable {}

// MARK: - Encoding

extension BuildOperationEnded: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [
            .int64(buildNumber),
            .int64(status.rawValue),
            unknown,
        ]
    }
}
