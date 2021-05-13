import Foundation
import MessagePack
import XCBProtocol

public enum BuildPlatform: String, Decodable {
    case macosx
    case iphoneos
    case iphonesimulator
    case watchos
    case watchsimulator
    case appletvos
    case appletvsimulator
}

extension BuildPlatform: CustomStringConvertible {
    public var description: String { rawValue }
}

// MARK: - Encoding

extension BuildPlatform: CustomEncodableRPCPayload {
    public func encode() -> MessagePackValue {
        return .string(rawValue)
    }
}
