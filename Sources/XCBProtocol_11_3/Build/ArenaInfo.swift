import Foundation
import MessagePack
import XCBProtocol

public struct ArenaInfo {
    public let derivedDataPath: String // e.g. "/Users/USER/Library/Developer/Xcode/DerivedData"
    public let buildProductsPath: String // e.g. "/Users/USER/Library/Developer/Xcode/DerivedData/PROJECT-HASH/Build/Products"
    public let buildIntermediatesPath: String // e.g. "/Users/USER/Library/Developer/Xcode/DerivedData/PROJECT-HASH/Build/Intermediates.noindex"
    public let pchPath: String // e.g. "/Users/USER/Library/Developer/Xcode/DerivedData/PROJECT-HASH/Build/Intermediates.noindex/PrecompiledHeaders"
    public let indexPCHPath: String // e.g. "/Users/USER/Library/Developer/Xcode/DerivedData/PROJECT-HASH/Index/PrecompiledHeaders"
    public let indexDataStoreFolderPath: String // e.g. "/Users/USER/Library/Developer/Xcode/DerivedData/PROJECT-HASH/Index/DataStore"
    public let indexEnableDataStore: Bool
}

// MARK: - Decoding

extension ArenaInfo: Decodable {}
