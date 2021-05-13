import Foundation
import MessagePack
import XCBProtocol

public struct BuildOperationDiagnosticEmitted {
    public let kind: BuildOperationDiagnosticKind
    public let location: BuildOperationDiagnosticLocation
    public let message: String
    public let component: BuildOperationDiagnosticComponent
    public let unknown1: String // e.g. "default"
    public let appendToOutputStream: Bool // If `true`, it's attached to the output instead of showing as a new entry
    public let unknown2: MessagePackValue // Might be `fixIts`
    public let unknown3: MessagePackValue // Might be `childDiagnostics`
    public let unknown4: MessagePackValue
    
    public init(
        kind: BuildOperationDiagnosticKind,
        location: BuildOperationDiagnosticLocation,
        message: String,
        component: BuildOperationDiagnosticComponent,
        unknown: String,
        appendToOutputStream: Bool
    ) {
        self.kind = kind
        self.location = location
        self.message = message
        self.component = component
        self.unknown1 = unknown
        self.appendToOutputStream = appendToOutputStream
        self.unknown2 = .array([])
        self.unknown3 = .array([])
        self.unknown4 = .array([])
    }
}

// MARK: - ResponsePayloadConvertible

extension BuildOperationDiagnosticEmitted: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .buildOperationDiagnostic(self) }
}

// MARK: - Decoding

extension BuildOperationDiagnosticEmitted: Decodable {}

// MARK: - Encoding

extension BuildOperationDiagnosticEmitted: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [
            .int64(kind.rawValue),
            .array(location.encode()),
            .string(message),
            .array(component.encode()),
            .string(unknown1),
            .bool(appendToOutputStream),
            unknown2,
            unknown3,
            unknown4,
        ]
    }
}
