import Foundation
import MessagePack
import XCBProtocol

public struct SetSessionSystemInfoRequest {
    public let sessionHandle: String
    public let osMajorVersion: UInt64
    public let osMinorVersion: UInt64
    public let osPatchVersion: UInt64
    public let xcodeBuildVersion: String // Called `productBuildVersion` by Xcode
    public let nativeArchitecture: String
}

extension SetSessionSystemInfoRequest: Decodable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        
        // Name is at index 0
        _ = try container.decode(String.self)

        var nestedContainer = try container.nestedUnkeyedContainer()
        self.sessionHandle = try nestedContainer.decode()
        self.osMajorVersion = try nestedContainer.decode()
        self.osMinorVersion = try nestedContainer.decode()
        try nestedContainer.throwIfNotAtEnd()
        
        self.osPatchVersion = try container.decode()
        self.xcodeBuildVersion = try container.decode()
        self.nativeArchitecture = try container.decode()

        try container.throwIfNotAtEnd()
    }
}
