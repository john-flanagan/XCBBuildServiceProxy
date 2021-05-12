import Foundation

extension UnkeyedDecodingContainer {
    public func throwIfNotAtEnd() throws {
        if !isAtEnd {
            let description = "Decoded \(currentIndex) values. Have \(count ?? Int.min)."
            throw DecodingError.dataCorruptedError(in: self, debugDescription: description)
        }
    }
    
    public mutating func decode<T: Decodable>() throws -> T {
        try decode(T.self)
    }
}
