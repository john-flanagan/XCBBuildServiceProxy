import Foundation
import MessagePack
import XCBProtocol

public struct BuildOperationTaskEnded {
    public let taskID: Int64
    public let status: BuildOperationStatus
    public let skippedErrorsFromSerializedDiagnostics: Bool // Might be named "signalled"
    public let metrics: BuildOperationTaskMetrics?
    
    public init(taskID: Int64, status: BuildOperationStatus, skippedErrorsFromSerializedDiagnostics: Bool, metrics: BuildOperationTaskMetrics?) {
        self.taskID = taskID
        self.status = status
        self.skippedErrorsFromSerializedDiagnostics = skippedErrorsFromSerializedDiagnostics
        self.metrics = metrics
    }
}

// MARK: - ResponsePayloadConvertible

extension BuildOperationTaskEnded: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .buildOperationTaskEnded(self) }
}

// MARK: - Decoding

extension BuildOperationTaskEnded: Decodable {}

// MARK: - Encoding

extension BuildOperationTaskEnded: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [
            .int64(taskID),
            .int64(status.rawValue),
            .bool(skippedErrorsFromSerializedDiagnostics),
            metrics.flatMap { MessagePackValue.array($0.encode()) } ?? .nil,
        ]
    }
}
