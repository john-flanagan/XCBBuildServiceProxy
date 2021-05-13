import Foundation
import MessagePack
import XCBProtocol

public enum BuildCommand: Int64 {
    case build
    case prepareForIndexing
    case migrate
    case generateAssemblyCode
    case generatePreprocessedFile
    case cleanBuildFolder
    case preview
}

// MARK: - Decoding

extension BuildCommand: Decodable {}
