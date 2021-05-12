import Foundation

struct MessagePackDecoderKeyedContainer<Key: CodingKey> {
    let codingPath: [CodingKey]

    let content: [String: MessagePackValue]
    
    init(value: MessagePackValue, codingPath: [CodingKey]) throws {
        guard case .map(let dictionary) = value else {
            throw DecodingError.typeMismatch(at: codingPath, expectation: [String: MessagePackValue].self, reality: value)
        }
        
        self.codingPath = codingPath
        self.content = dictionary.reduce(into: [:]) { result, pair in
            guard case .string(let key) = pair.key else { return }
            result[key] = pair.value
        }
    }
    
    /// Attempt to transform the value for a given key using the provided transformation.
    ///
    /// - Parameters:
    ///   - key: The key used to lookup a value.
    ///   - transform: Closure to perform on the value associated with `key`.
    ///   - codingPath: The coding path for the value.
    ///   - value: The value associated with `key`.
    /// - Returns: The result of performing `transform` on `value`.
    /// - Throws: `DecodingError.keyNotFound` if there is no values for the key.
    private func mapValue<T>(forKey key: Key, transform: (_ value: MessagePackValue, _ codingPath: [CodingKey]) throws -> T) throws -> T {
        let newCodingPath = codingPath + [key]
        
        guard let value = content[key.stringValue] else {
            throw DecodingError.keyNotFound(
                key,
                DecodingError.Context(codingPath: newCodingPath, debugDescription: "No value associated with key \(key.stringValue)).")
            )
        }
        
        return try transform(value, newCodingPath)
    }
}

// MARK: - KeyedDecodingContainerProtocol

extension MessagePackDecoderKeyedContainer: KeyedDecodingContainerProtocol {
    var allKeys: [Key] {
        content.keys.compactMap(Key.init(stringValue:))
    }

    func contains(_ key: Key) -> Bool {
        content.keys.contains(key.stringValue)
    }
    
    func nestedContainer<NestedKey: CodingKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> {
        KeyedDecodingContainer(
            try mapValue(forKey: key, transform: MessagePackDecoderKeyedContainer<NestedKey>.init)
        )
    }
    
    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        try mapValue(forKey: key, transform: MessagePackDecoderUnkeyedContainer.init)
    }
    
    func superDecoder() throws -> Decoder {
        let dictionary: [MessagePackValue: MessagePackValue] = content.reduce(into: [:]) { result, pair in
            result[.string(pair.key)] = pair.value
        }
        
        return _MessagePackDecoder(value: .map(dictionary), codingPath: codingPath + [MessagePackKey.super])
    }
    
    func superDecoder(forKey key: Key) throws -> Decoder {
        try mapValue(forKey: key) {
            _MessagePackDecoder(value: $0, codingPath: $1 + [MessagePackKey.super])
        }
    }
    
    // MARK: Decoding
    
    func decodeNil(forKey key: Key) throws -> Bool {
        switch content[key.stringValue] {
        case .nil, .none: return true
        default: return false
        }
    }

    func decode<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> T {
        try mapValue(forKey: key) { value, codingPath in
            try T(from: _MessagePackDecoder(value: value, codingPath: codingPath))
        }
    }

    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        try mapValue(forKey: key) { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }

    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        try mapValue(forKey: key) { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }

    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        try mapValue(forKey: key) { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }

    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        try mapValue(forKey: key) { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }

    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        try mapValue(forKey: key) { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }

    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        try mapValue(forKey: key) { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }

    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        try mapValue(forKey: key) { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }

    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        try mapValue(forKey: key) { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }

    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        try mapValue(forKey: key) { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }

    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        try mapValue(forKey: key) { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }

    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        try mapValue(forKey: key) { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }

    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        try mapValue(forKey: key) { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }

    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        try mapValue(forKey: key) { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }

    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        try mapValue(forKey: key) { value, codingPath in
            try value.decode(type, codingPath: codingPath)
        }
    }
}
