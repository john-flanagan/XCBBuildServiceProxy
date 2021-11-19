import Foundation

struct MessagePackDecoderKeyedContainer<Key: CodingKey> {
    let codingPath: [CodingKey]

    let content: Content

    private let metadata: EnumMetadata

    init(value: MessagePackValue, codingPath: [CodingKey]) throws {
        guard let metadata = EnumMetadata(Key.self) else {
            let message = "\(Key.self) must be an enum to be used for MessagePack decoding."
            throw DecodingError.dataCorrupted(.init(codingPath: codingPath, debugDescription: message))
        }

        self.metadata = metadata
        self.codingPath = codingPath

        switch value {
        case .map(let dictionary):
            self.content = .dictionary(dictionary)

        case .array(let array):
            guard metadata.caseCount == UInt32(array.count) else {
                let message = "Payload contains \(array.count) values, but only \(metadata.caseCount) coding keys defined."
                throw DecodingError.dataCorrupted(.init(codingPath: codingPath, debugDescription: message))
            }

            self.content = .array(array)

        default:
            let message = "Expected to decode .map or .array but found \(value.description) instead."
            throw DecodingError.dataCorrupted(.init(codingPath: codingPath, debugDescription: message))
        }
    }

    /// Attempt to retrieve the value for a given key.
    ///
    /// This is implemented on `MessagePackDecoderKeyedContainer` instead of `Content` directly so there's easy access to
    /// `metadata`.
    ///
    /// - Parameter key: The key used to lookup value.
    /// - Returns: The value stored for the given key, if any.
    private func content(forKey key: Key) -> MessagePackValue? {
        switch content {
        case .dictionary(let dictionary):
            return dictionary[.string(key.stringValue)]

        case .array(let array):
            let tag = Int(metadata.tag(of: key))
            guard tag < array.count else { return nil }

            return array[tag]
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

        guard let value = content(forKey: key) else {
            let message = "No value associated with key \(key.stringValue))."
            throw DecodingError.keyNotFound(key, .init(codingPath: newCodingPath, debugDescription: message))
        }
        
        return try transform(value, newCodingPath)
    }
}

extension MessagePackDecoderKeyedContainer {
    enum Content {
        case dictionary([MessagePackValue: MessagePackValue])
        case array([MessagePackValue])

        func keys() -> [Key] {
            switch self {
            case .dictionary(let dictionary):
                return dictionary.keys.compactMap {
                    guard case .string(let key) = $0 else { return nil }
                    return Key(stringValue: key)
                }

            case .array(let array):
                return (0 ..< array.count).compactMap(Key.init(intValue:))
            }
        }

        var value: MessagePackValue {
            switch self {
            case .dictionary(let dictionary):
                return .map(dictionary)

            case .array(let array):
                return .array(array)
            }
        }
    }
}

// MARK: - KeyedDecodingContainerProtocol

extension MessagePackDecoderKeyedContainer: KeyedDecodingContainerProtocol {
    var allKeys: [Key] {
        content.keys()
    }

    func contains(_ key: Key) -> Bool {
        content(forKey: key) != nil
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
        _MessagePackDecoder(value: content.value, codingPath: codingPath + [MessagePackKey.super])
    }
    
    func superDecoder(forKey key: Key) throws -> Decoder {
        try mapValue(forKey: key) {
            _MessagePackDecoder(value: $0, codingPath: $1 + [MessagePackKey.super])
        }
    }
    
    // MARK: Decoding
    
    func decodeNil(forKey key: Key) throws -> Bool {
        switch content(forKey: key) {
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

// MARK: - EnumMetadata

// Derived from https://github.com/pointfreeco/swift-case-paths/blob/main/Sources/CasePaths/EnumReflection.swift
private struct EnumMetadata {
    let ptr: UnsafeRawPointer

    init?(_ type: Any.Type) {
        self.ptr = unsafeBitCast(type, to: UnsafeRawPointer.self)
        guard self.ptr.load(as: MetadataKind.self) == .enumeration else { return nil }
    }

    var caseCount: UInt32 { typeDescriptor.emptyCaseCount + typeDescriptor.payloadCaseCount }

    func tag<Enum>(of value: Enum) -> UInt32 {
        withUnsafePointer(to: value) {
            self.valueWitnessTable.getEnumTag($0, self.ptr)
        }
    }

    private var typeDescriptor: EnumTypeDescriptor {
        EnumTypeDescriptor(
            ptr: self.ptr.load(fromByteOffset: pointerSize, as: UnsafeRawPointer.self)
        )
    }

    private var valueWitnessTable: ValueWitnessTable {
        ValueWitnessTable(
            ptr: self.ptr.load(fromByteOffset: -pointerSize, as: UnsafeRawPointer.self)
        )
    }
}

private struct MetadataKind: Equatable {
    var rawValue: UInt

    // https://github.com/apple/swift/blob/main/include/swift/ABI/MetadataValues.h
    // https://github.com/apple/swift/blob/main/include/swift/ABI/MetadataKind.def
    static var enumeration: Self { .init(rawValue: 0x201) }
}

private struct EnumTypeDescriptor: Equatable {
    let ptr: UnsafeRawPointer

    var emptyCaseCount: UInt32 { self.ptr.load(fromByteOffset: 6 * 4, as: UInt32.self) }

    var payloadCaseCount: UInt32 { self.ptr.load(fromByteOffset: 5 * 4, as: UInt32.self) & 0xFFFFFF }
}

private struct ValueWitnessTable {
    let ptr: UnsafeRawPointer

    var getEnumTag: @convention(c) (_ value: UnsafeRawPointer, _ metadata: UnsafeRawPointer) -> UInt32 {
        self.ptr.advanced(by: 10 * pointerSize + 2 * 4).loadInferredType()
    }
}

extension UnsafeRawPointer {
    fileprivate func loadInferredType<Type>() -> Type {
        self.load(as: Type.self)
    }
}

// This is the size of any Unsafe*Pointer and also the size of Int and UInt.
private let pointerSize = MemoryLayout<UnsafeRawPointer>.size
