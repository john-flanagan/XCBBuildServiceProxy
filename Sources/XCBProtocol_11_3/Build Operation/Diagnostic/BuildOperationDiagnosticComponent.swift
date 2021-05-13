import Foundation
import MessagePack
import XCBProtocol

public enum BuildOperationDiagnosticComponent {
    case task(taskID: Int64, targetID: Int64)
    case unknown(MessagePackValue) // Haven't seen it
    case global
}

// MARK: - Decoding

extension BuildOperationDiagnosticComponent: Decodable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()

        let rawValue = try container.decode(Int64.self)

        switch rawValue {
        case 0:
            var taskContainer = try container.nestedUnkeyedContainer()

            self = .task(
                taskID: try taskContainer.decode(),
                targetID: try taskContainer.decode()
            )
            
            try taskContainer.throwIfNotAtEnd()

        case 1:
            self = .unknown(try container.decode())

        case 2:
            self = .global

        default:
            throw DecodingError.unknownRawValue(rawValue, at: decoder.codingPath, forType: Self.self)
        }

        try container.throwIfNotAtEnd()
    }
}

// MARK: - Encoding

extension BuildOperationDiagnosticComponent: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        switch self {
        case let .task(taskID, parentTaskID):
            return [
                .int64(0),
                .array([
                    .int64(taskID),
                    .int64(parentTaskID),
                ]),
            ]
            
        case let .unknown(unknown):
            return [
                .int64(1),
                unknown,
            ]
                
        case .global:
            return [
                .int64(2),
                .nil,
            ]
        }
    }
}
