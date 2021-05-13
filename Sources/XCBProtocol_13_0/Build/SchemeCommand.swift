import Foundation
import MessagePack
import XCBProtocol

public enum SchemeCommand: Int64, Decodable {
    case launch
    case test
    case profile
    case archive
}
