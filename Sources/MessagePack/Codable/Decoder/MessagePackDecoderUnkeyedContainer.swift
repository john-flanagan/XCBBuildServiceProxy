import Foundation

struct MessagePackDecoderUnkeyedContainer {
    let codingPath: [CodingKey]

    private(set) var currentIndex: Int = 0
        
    private let content: [MessagePackValue]

    init(value: MessagePackValue, codingPath: [CodingKey]) throws {
        guard case .array(let array) = value else {
            throw DecodingError.typeMismatch(at: codingPath, expectation: [MessagePackValue].self, reality: value)
        }
        
        self.codingPath = codingPath
        self.content = array
    }

    /// Attempt to transform the value at `currentIndex` using the provided transformation. If the
    /// value is successfully transformed `currentIndex` will be advanced by one.
    ///
    /// - Parameters:
    ///   - transform: Closure to perform on the value at `currentIndex`.
    ///   - value: The value at `currentIndex`.
    ///   - codingPath: The coding path for consumed value.
    /// - Returns: The result of performing `transform` on `values`.
    /// - Throws: `DecodingError.valueNotFound` if there are no values remaining.
    private mutating func consumeValue<T>(_ transform: (_ value: MessagePackValue, _ codingPath: [CodingKey]) throws -> T) throws -> T {
        try throwErrorIfAtEnd(T.self)

        let result: T = try transform(content[currentIndex], codingPath + [MessagePackKey(index: currentIndex)])
        
        currentIndex += 1
        
        return result
    }
    
    /// Throw `DecodingError.valueNotFound` error if `currentIndex` is at the end of `content`.
    private func throwErrorIfAtEnd<T>(_ type: T.Type) throws {
        if isAtEnd {
            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: codingPath + [MessagePackKey(index: currentIndex)], debugDescription: "Unkeyed container is at end."))
        }
    }
}

// MARK: - UnkeyedDecodingContainer

extension MessagePackDecoderUnkeyedContainer: UnkeyedDecodingContainer {
    var count: Int? {
        content.count
    }

    var isAtEnd: Bool {
        currentIndex >= content.count
    }
    
    mutating func nestedContainer<NestedKey: CodingKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> {
        KeyedDecodingContainer(
            try consumeValue(MessagePackDecoderKeyedContainer<NestedKey>.init)
        )
    }
    
    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        try consumeValue(MessagePackDecoderUnkeyedContainer.init)
    }
    
    mutating func superDecoder() throws -> Decoder {
        _MessagePackDecoder(value: .array(content), codingPath: codingPath)
    }
    
    // MARK: Decoding

    mutating func decodeNil() throws -> Bool {
        try throwErrorIfAtEnd(Any?.self)
        
        if case .nil = content[currentIndex] {
            currentIndex += 1
            return true
        }
        
        return false
    }

    mutating func decode<T: Decodable>(_ type: T.Type) throws -> T {
        try consumeValue { value, codingPath in
            try T(from: _MessagePackDecoder(value: value, codingPath: codingPath))
        }
    }

    mutating func decode(_ type: Bool.Type) throws -> Bool {
        try consumeValue { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }

    mutating func decode(_ type: String.Type) throws -> String {
        try consumeValue { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }
    
    mutating func decode(_ type: Double.Type) throws -> Double {
        try consumeValue { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }
    
    mutating func decode(_ type: Float.Type) throws -> Float {
        try consumeValue { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }
    
    mutating func decode(_ type: Int.Type) throws -> Int {
        try consumeValue { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }
    
    mutating func decode(_ type: Int8.Type) throws -> Int8 {
        try consumeValue { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }
    
    mutating func decode(_ type: Int16.Type) throws -> Int16 {
        try consumeValue { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }
    
    mutating func decode(_ type: Int32.Type) throws -> Int32 {
        try consumeValue { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }
    
    mutating func decode(_ type: Int64.Type) throws -> Int64 {
        try consumeValue { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }
    
    mutating func decode(_ type: UInt.Type) throws -> UInt {
        try consumeValue { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }
    
    mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        try consumeValue { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }
    
    mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        try consumeValue { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }
    
    mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        try consumeValue { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }
    
    mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        try consumeValue { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }
}
