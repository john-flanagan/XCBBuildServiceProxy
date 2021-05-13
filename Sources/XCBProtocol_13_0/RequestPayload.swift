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
        case "SET_SESSION_SYSTEM_INFO": self = .setSessionSystemInfo(try container.decode()) // TODO: Was this really supposed to be `indexPath` before?
        case "SET_SESSION_USER_INFO": self = .setSessionUserInfo(try container.decode())

        case "CREATE_BUILD":
            let data = try container.decode(Data.self)
            self = .createBuildRequest(try JSONDecoder().decode(CreateBuildRequest.self, from: data))

        case "BUILD_START": self = .buildStartRequest(try container.decode())
        case "BUILD_CANCEL": self = .buildCancelRequest(try container.decode())

        case "INDEXING_INFO_REQUESTED":
            let data = try container.decode(Data.self)
            self = .indexingInfoRequest(try JSONDecoder().decode(IndexingInfoRequest.self, from: data))

        case "PREVIEW_INFO_REQUESTED":
            let data = try container.decode(Data.self)
            self = .previewInfoRequest(try JSONDecoder().decode(PreviewInfoRequest.self, from: data))

        default: self = .unknownRequest(.init(values: try container.decode()))
        }
    }
    
    public var createSessionXcodePath: String? {
        switch self {
        case .createSession(let message): return message.appPath
        default: return nil
        }
    }
}
