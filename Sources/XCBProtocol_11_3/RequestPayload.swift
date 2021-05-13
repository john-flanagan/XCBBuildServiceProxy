import Foundation
import MessagePack
import XCBProtocol

public enum RequestPayload {
    case createSession(CreateSessionRequest)
    case transferSessionPIFRequest(TransferSessionPIFRequest)
    case setSessionSystemInfo(SetSessionSystemInfoRequest)
    case setSessionUserInfo(SetSessionUserInfoRequest)
    
    case createBuildRequest(CreateBuildRequest)
    case buildStartRequest(BuildStartRequest)
    case buildCancelRequest(BuildCancelRequest)
    
    case indexingInfoRequest(IndexingInfoRequest)
    
    case previewInfoRequest(PreviewInfoRequest)
    
    case unknownRequest(UnknownRequest)
}

public struct UnknownRequest {
    public let values: [MessagePackValue]
}

// MARK: - Encoding

extension RequestPayload: XCBProtocol.RequestPayload {
    public static func unknownRequest(values: [MessagePackValue]) -> Self {
        return .unknownRequest(.init(values: values))
    }
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        
        let name = try container.decode(String.self)
        
        switch name {
        case "CREATE_SESSION": self = .createSession(try container.decode())
        case "TRANSFER_SESSION_PIF_REQUEST": self = .transferSessionPIFRequest(try container.decode())
        case "SET_SESSION_SYSTEM_INFO": self = .setSessionSystemInfo(try container.decode())
        case "SET_SESSION_USER_INFO": self = .setSessionUserInfo(try container.decode())
        case "CREATE_BUILD": self = .createBuildRequest(try container.decode())
        case "BUILD_START": self = .buildStartRequest(try container.decode())
        case "BUILD_CANCEL": self = .buildCancelRequest(try container.decode())
        case "INDEXING_INFO_REQUESTED": self = .indexingInfoRequest(try container.decode())
        case "PREVIEW_INFO_REQUESTED": self = .previewInfoRequest(try container.decode())
            
        default: self = .unknownRequest(.init(values: try container.decode([MessagePackValue].self)))
        }
    }
    
    public var createSessionXcodePath: String? {
        switch self {
        case .createSession(let message): return message.appPath
        default: return nil
        }
    }
}
