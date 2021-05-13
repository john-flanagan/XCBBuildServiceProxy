import Foundation
import MessagePack
import XCBProtocol

public struct BuildStartRequest: Decodable {
    public let sessionHandle: String
    public let buildNumber: Int64
}
