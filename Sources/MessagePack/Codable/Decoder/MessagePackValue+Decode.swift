import Foundation

extension MessagePackValue: Decodable {
    public init(from decoder: Decoder) throws {
        guard let messagePackDecoder = decoder as? _MessagePackDecoder else {
            let message = "MessagePackValue only supports decoding via _MessagePackDecoder"
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: message))
        }
        
        self = messagePackDecoder.value
    }
}

extension MessagePackValue {
    var isNil: Bool {
        if case .nil = self {
            return true
        }

        return false
    }

    func decode(_ type: Bool.Type, codingPath: [CodingKey]) throws -> Bool {
        guard case .bool(let value) = self else {
            throw DecodingError.typeMismatch(at: codingPath, expectation: type, reality: self)
        }
        return value
    }

    func decode(_ type: String.Type, codingPath: [CodingKey]) throws -> String {
        guard case .string(let value) = self else {
            throw DecodingError.typeMismatch(at: codingPath, expectation: type, reality: self)
        }
        return value
    }

    func decode(_ type: Double.Type, codingPath: [CodingKey]) throws -> Double {
        guard case .double(let value) = self else {
            throw DecodingError.typeMismatch(at: codingPath, expectation: type, reality: self)
        }
        return value
    }

    func decode(_ type: Float.Type, codingPath: [CodingKey]) throws -> Float {
        guard case .float(let value) = self else {
            throw DecodingError.typeMismatch(at: codingPath, expectation: type, reality: self)
        }
        return value
    }

    func decode(_ type: Int.Type, codingPath: [CodingKey]) throws -> Int {
        let message = "Cannot decode type `Int`. Use `Int8`, `Int16`, `Int32`, or `Int64` instead."
        throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: codingPath, debugDescription: message))
    }

    func decode(_ type: Int8.Type, codingPath: [CodingKey]) throws -> Int8 {
        guard case .int8(let value) = self else {
            throw DecodingError.typeMismatch(at: codingPath, expectation: type, reality: self)
        }
        return value
    }

    func decode(_ type: Int16.Type, codingPath: [CodingKey]) throws -> Int16 {
        guard case .int16(let value) = self else {
            throw DecodingError.typeMismatch(at: codingPath, expectation: type, reality: self)
        }
        return value
    }

    func decode(_ type: Int32.Type, codingPath: [CodingKey]) throws -> Int32 {
        guard case .int32(let value) = self else {
            throw DecodingError.typeMismatch(at: codingPath, expectation: type, reality: self)
        }
        return value
    }

    func decode(_ type: Int64.Type, codingPath: [CodingKey]) throws -> Int64 {
        guard case .int64(let value) = self else {
            throw DecodingError.typeMismatch(at: codingPath, expectation: type, reality: self)
        }
        return value
    }

    func decode(_ type: UInt.Type, codingPath: [CodingKey]) throws -> UInt {
        let message = "Cannot decode type `UInt`. Use `UInt8`, `UInt16`, `UInt32`, or `UInt64` instead."
        throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: codingPath, debugDescription: message))
    }

    func decode(_ type: UInt8.Type, codingPath: [CodingKey]) throws -> UInt8 {
        guard case .uint8(let value) = self else {
            throw DecodingError.typeMismatch(at: codingPath, expectation: type, reality: self)
        }
        return value
    }

    func decode(_ type: UInt16.Type, codingPath: [CodingKey]) throws -> UInt16 {
        guard case .uint16(let value) = self else {
            throw DecodingError.typeMismatch(at: codingPath, expectation: type, reality: self)
        }
        return value
    }

    func decode(_ type: UInt32.Type, codingPath: [CodingKey]) throws -> UInt32 {
        guard case .uint32(let value) = self else {
            throw DecodingError.typeMismatch(at: codingPath, expectation: type, reality: self)
        }
        return value
    }

    func decode(_ type: UInt64.Type, codingPath: [CodingKey]) throws -> UInt64 {
        guard case .uint64(let value) = self else {
            throw DecodingError.typeMismatch(at: codingPath, expectation: type, reality: self)
        }
        return value
    }
}
