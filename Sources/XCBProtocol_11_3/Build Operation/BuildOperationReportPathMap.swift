import Foundation
import MessagePack
import XCBProtocol

public struct BuildOperationReportPathMap {
    public let unknown1: MessagePackValue
    public let unknown2: MessagePackValue
    
    public init() {
        self.unknown1 = .map([:])
        self.unknown2 = .map([:])
    }
}

// MARK: - ResponsePayloadConvertible

extension BuildOperationReportPathMap: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .buildOperationReportPathMap(self) }
}

// MARK: - Decoding

extension BuildOperationReportPathMap: Decodable {}

// MARK: - Encoding

extension BuildOperationReportPathMap: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [
            unknown1,
            unknown2,
        ]
    }
}
