import Foundation
import MessagePack
import XCBProtocol

public struct BuildOperationProjectInfo {
    public let name: String
    public let path: String
    public let isPackage: Bool
    
    public init(name: String, path: String, isPackage: Bool) {
        self.name = name
        self.path = path
        self.isPackage = isPackage
    }
}

// MARK: - Decoding

extension BuildOperationProjectInfo: Decodable {}

// MARK: - Encoding

extension BuildOperationProjectInfo: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [
            .string(name),
            .string(path),
            .bool(isPackage),
        ]
    }
}
