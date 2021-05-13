import Foundation
import MessagePack
import XCBProtocol

public struct BuildOperationConsoleOutputEmitted {
    public let taskID: Int64
    public let unknown: MessagePackValue
    public let output: Data
    
    public init(taskID: Int64, output: Data) {
        self.taskID = taskID
        self.unknown = .nil
        self.output = output
    }
}

// MARK: - ResponsePayloadConvertible

extension BuildOperationConsoleOutputEmitted: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .buildOperationConsoleOutput(self) }
}

// MARK: - Decoding

extension BuildOperationConsoleOutputEmitted: Decodable {}

// MARK: - Encoding

extension BuildOperationConsoleOutputEmitted: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [
            .binary(output),
            unknown,
            .int64(taskID),
        ]
    }
}
