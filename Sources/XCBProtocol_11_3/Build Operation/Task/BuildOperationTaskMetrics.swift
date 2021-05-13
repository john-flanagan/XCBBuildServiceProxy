import Foundation
import MessagePack
import XCBProtocol

public struct BuildOperationTaskMetrics {
    public let utime: UInt64
    public let stime: UInt64
    public let maxRSS: UInt64
    public let wcStartTime: UInt64
    public let wcDuration: UInt64
    
    public init(
        utime: UInt64,
        stime: UInt64,
        maxRSS: UInt64,
        wcStartTime: UInt64,
        wcDuration: UInt64
    ) {
        self.utime = utime
        self.stime = stime
        self.maxRSS = maxRSS
        self.wcStartTime = wcStartTime
        self.wcDuration = wcDuration
    }
}

// MARK: - Decoding

extension BuildOperationTaskMetrics: Decodable {}

// MARK: - Encoding

extension BuildOperationTaskMetrics: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [
            .uint64(utime),
            .uint64(stime),
            .uint64(maxRSS),
            .uint64(wcStartTime),
            .uint64(wcDuration),
        ]
    }
}
