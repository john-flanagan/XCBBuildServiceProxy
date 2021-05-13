import Foundation
import MessagePack
import XCBProtocol

public struct IndexingInfoRequest {
    public let sessionHandle: String
    public let responseChannel: UInt64
    public let buildRequest: BuildRequest // Called `request` by Xcode
    public let targetGUID: String // Called `targetID` by Xcode
    public let unknown1: MessagePackValue
    public let unknown2: Bool
}

// MARK: - Decoding

extension IndexingInfoRequest: Decodable {}
