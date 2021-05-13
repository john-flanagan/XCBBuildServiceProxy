import Foundation
import MessagePack
import XCBProtocol

public struct CreateSessionRequest {
    public let name: String
    public let appPath: String
    public let cachePath: String
    public let inferiorProductsPath: String?
}

// MARK: - Decoding

extension CreateSessionRequest: Decodable {}
