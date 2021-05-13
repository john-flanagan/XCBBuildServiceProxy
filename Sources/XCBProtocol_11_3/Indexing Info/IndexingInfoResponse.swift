import Foundation
import MessagePack
import XCBProtocol

public struct IndexingInfoResponse {
    public let targetGUID: String // Called `targetID` by Xcode
    public let data: Data
    
    public init(targetGUID: String, data: Data) {
        self.targetGUID = targetGUID
        self.data = data
    }
}

// MARK: - ResponsePayloadConvertible

extension IndexingInfoResponse: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .indexingInfo(self) }
}

// MARK: - Decoding

extension IndexingInfoResponse: Decodable {}

// MARK: - Encoding

extension IndexingInfoResponse: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [
            .string(targetGUID),
            .binary(data),
        ]
    }
}
