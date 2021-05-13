import Foundation
import MessagePack
import XCBProtocol

public struct PreviewInfoResponse {
    public let targetGUID: String // Called `targetID` by Xcode
    public let infos: [PreviewInfo] // Not named correctly
    
    public init(targetGUID: String, infos: [PreviewInfo]) {
        self.targetGUID = targetGUID
        self.infos = infos
    }
}

// MARK: - ResponsePayloadConvertible

extension PreviewInfoResponse: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .previewInfo(self) }
}

// MARK: - Decoding

extension PreviewInfoResponse: Decodable {}

// MARK: - Encoding

extension PreviewInfoResponse: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [
            .string(targetGUID),
            .array(infos.map { .array($0.encode()) }),
        ]
    }
}
