import Foundation
import MessagePack
import XCBProtocol

public struct SettingsOverrides: Decodable {
    public let synthesized: [String: String] // e.g. ["TARGET_DEVICE_MODEL": "iPhone12,5", "TARGET_DEVICE_OS_VERSION": "13.3"]
    public let commandLine: [String: String]
    public let commandLineConfig: [String: String]
    public let environmentConfig: [String: String]
    public let toolchainOverride: String? // e.g. "org.swift.515120200323a"
}

