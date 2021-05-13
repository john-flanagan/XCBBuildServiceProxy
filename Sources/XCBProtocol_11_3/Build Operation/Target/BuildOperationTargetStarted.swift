import Foundation
import MessagePack
import XCBProtocol

public struct BuildOperationTargetStarted {
    public let targetID: Int64
    public let guid: String // Used in `CreateBuildRequest` and `BuildOperationTargetUpToDate`
    public let targetInfo: BuildOperationTargetInfo
    
    public init(targetID: Int64, guid: String, targetInfo: BuildOperationTargetInfo) {
        self.targetID = targetID
        self.guid = guid
        self.targetInfo = targetInfo
    }
}

// MARK: - ResponsePayloadConvertible

extension BuildOperationTargetStarted: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .buildOperationTargetStarted(self) }
}

// MARK: - Decoding

extension BuildOperationTargetStarted: Decodable {}

// MARK: - Encoding

extension BuildOperationTargetStarted: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [
            .int64(targetID),
            .string(guid),
            .array(targetInfo.encode()),
        ]
    }
}
