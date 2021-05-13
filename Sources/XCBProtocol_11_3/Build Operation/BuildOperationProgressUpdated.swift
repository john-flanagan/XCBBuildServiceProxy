import Foundation
import MessagePack
import XCBProtocol

public struct BuildOperationProgressUpdated {
    public let targetName: String?
    public let statusMessage: String
    public let percentComplete: Double
    public let showInLog: Bool
    
    public init(targetName: String?, statusMessage: String, percentComplete: Double, showInLog: Bool) {
        self.targetName = targetName
        self.statusMessage = statusMessage
        self.percentComplete = percentComplete
        self.showInLog = showInLog
    }
}

// MARK: - ResponsePayloadConvertible

extension BuildOperationProgressUpdated: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .buildOperationProgressUpdated(self) }
}

// MARK: - Decoding

extension BuildOperationProgressUpdated: Decodable {}

// MARK: - Encoding

extension BuildOperationProgressUpdated: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [
            targetName.flatMap { .string($0) } ?? .nil,
            .string(statusMessage),
            .double(percentComplete),
            .bool(showInLog),
        ]
    }
}
