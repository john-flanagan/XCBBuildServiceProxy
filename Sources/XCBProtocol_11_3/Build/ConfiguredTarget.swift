import Foundation
import MessagePack
import XCBProtocol

public struct ConfiguredTarget {
    public let guid: String
    public let parameters: BuildParameters?
}

// MARK: - Decoding

extension ConfiguredTarget: Decodable {}
