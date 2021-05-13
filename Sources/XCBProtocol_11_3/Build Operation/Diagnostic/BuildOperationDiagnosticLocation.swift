import Foundation
import MessagePack
import XCBProtocol

// Probably named wrong
public enum BuildOperationDiagnosticLocation {
    case alternativeMessage(String) // Might be named wrong. Always empty so far.
    case locationContext(file: String, line: Int64, column: Int64)
}

// MARK: - Decoding

extension BuildOperationDiagnosticLocation: Decodable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()

        let rawValue = try container.decode(Int64.self)
        
        switch rawValue {
        case 0:
            self = .alternativeMessage(try container.decode())
            
        case 1:
            var nestedContainer = try container.nestedUnkeyedContainer()
            
            self = .locationContext(
                file: try nestedContainer.decode(),
                line: try nestedContainer.decode(),
                column: try nestedContainer.decode()
            )

            try nestedContainer.throwIfNotAtEnd()
            
        default:
            throw DecodingError.unknownRawValue(rawValue, at: decoder.codingPath, forType: Self.self)
        }

        try container.throwIfNotAtEnd()
    }
}

// MARK: - Encoding

extension BuildOperationDiagnosticLocation: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        switch self {
        case let .alternativeMessage(message):
            return [
                .int64(0),
                .string(message),
            ]
            
        case let .locationContext(file, line, column):
            return [
                .int64(1),
                .array([
                    .string(file),
                    .int64(line),
                    .int64(column),
                ]),
            ]
        }
    }
}
