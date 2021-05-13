import Foundation
import MessagePack
import XCBProtocol

public struct PlanningOperationDidFinish {
    public let sessionHandle: String
    public let guid: String
    
    public init(sessionHandle: String, guid: String) {
        self.sessionHandle = sessionHandle
        self.guid = guid
    }
}

// MARK: - ResponsePayloadConvertible

extension PlanningOperationDidFinish: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .planningOperationDidFinish(self) }
}

// MARK: - Decoding

extension PlanningOperationDidFinish: Decodable {}

// MARK: - Encoding

extension PlanningOperationDidFinish: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [.string(sessionHandle), .string(guid)]
    }
}
