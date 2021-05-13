import Foundation
import MessagePack
import XCBProtocol

public struct CreateBuildRequest {
    public let sessionHandle: String
    public let responseChannel: UInt64
    public let buildRequest: BuildRequest // Called `request` by Xcode
}

// MARK: - Decoding

extension CreateBuildRequest: Decodable {}
