import Foundation
import MessagePack
import XCBProtocol

public struct CreateBuildRequest {
    public let sessionHandle: String
    public let responseChannel: UInt64
    public let buildRequest: BuildRequest // Called `request` by Xcode
    public let unknown: Bool
}

// MARK: - Decoding

extension CreateBuildRequest: Decodable {}
