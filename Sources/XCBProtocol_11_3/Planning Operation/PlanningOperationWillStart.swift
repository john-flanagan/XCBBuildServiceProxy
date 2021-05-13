import Foundation
import MessagePack
import XCBProtocol

public struct PlanningOperationWillStart {
    public let sessionHandle: String
    public let guid: String
    
    public init(sessionHandle: String, guid: String) {
        self.sessionHandle = sessionHandle
        self.guid = guid
    }
}

// MARK: - ResponsePayloadConvertible

extension PlanningOperationWillStart: ResponsePayloadConvertible {
    public func toResponsePayload() -> ResponsePayload { .planningOperationWillStart(self) }
}

// MARK: - Decoding

extension PlanningOperationWillStart: Decodable {}

// MARK: - Encoding

extension PlanningOperationWillStart: EncodableRPCPayload {
    public func encode() -> [MessagePackValue] {
        return [.string(sessionHandle), .string(guid)]
    }
}
