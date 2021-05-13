import Foundation
import MessagePack
import XCBProtocol

public struct BuildOperationTargetUpToDate {
    public let guid: String
    
    public init(guid: String) {
        self.guid = guid
    }
}

// MARK: - ResponsePayloadConvertible

extension BuildOperationTargetUpToDate: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .buildOperationTargetUpToDate(self) }
}

// MARK: - Decoding

extension BuildOperationTargetUpToDate: Decodable {}

// MARK: - Encoding

extension BuildOperationTargetUpToDate: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [.string(guid)]
    }
}
