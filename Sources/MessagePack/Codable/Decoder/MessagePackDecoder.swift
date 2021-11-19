import Foundation

public class MessagePackDecoder {
    public let userInfo: [CodingUserInfoKey: Any] = [:]

    public init() {}
    
    public func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        let values = try MessagePackValue.unpackAll(data)
        
        return try decode(type, from: values)
    }

    public func decode<T: Decodable>(_ type: T.Type, from value: MessagePackValue) throws -> T {
        return try _MessagePackDecoder(value: value, codingPath: []).decode(type)
    }

    public func decode<T: Decodable>(_ type: T.Type, from values: [MessagePackValue]) throws -> T {
        return try _MessagePackDecoder(value: .array(values), codingPath: []).decode(type)
    }
}

struct _MessagePackDecoder: Decoder {
    let codingPath: [CodingKey]
    
    let userInfo: [CodingUserInfoKey: Any] = [:]
    
    let value: MessagePackValue

    init(value: MessagePackValue, codingPath: [CodingKey]) {
        self.codingPath = codingPath
        self.value = value
    }

    func container<Key: CodingKey>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> {
        KeyedDecodingContainer(try MessagePackDecoderKeyedContainer(value: value, codingPath: codingPath))
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        try MessagePackDecoderUnkeyedContainer(value: value, codingPath: codingPath)
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        self
    }
}

extension _MessagePackDecoder: SingleValueDecodingContainer {
    func decodeNil() -> Bool {
        value.isNil
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        try T(from: self)
    }
    
    func decode(_ type: Bool.Type) throws -> Bool {
        try value.decode(type, codingPath: codingPath)
    }
    
    func decode(_ type: String.Type) throws -> String {
        try value.decode(type, codingPath: codingPath)
    }
    
    func decode(_ type: Double.Type) throws -> Double {
        try value.decode(type, codingPath: codingPath)
    }
    
    func decode(_ type: Float.Type) throws -> Float {
        try value.decode(type, codingPath: codingPath)
    }
    
    func decode(_ type: Int.Type) throws -> Int {
        try value.decode(type, codingPath: codingPath)
    }
    
    func decode(_ type: Int8.Type) throws -> Int8 {
        try value.decode(type, codingPath: codingPath)
    }
    
    func decode(_ type: Int16.Type) throws -> Int16 {
        try value.decode(type, codingPath: codingPath)
    }
    
    func decode(_ type: Int32.Type) throws -> Int32 {
        try value.decode(type, codingPath: codingPath)
    }
    
    func decode(_ type: Int64.Type) throws -> Int64 {
        try value.decode(type, codingPath: codingPath)
    }
    
    func decode(_ type: UInt.Type) throws -> UInt {
        try value.decode(type, codingPath: codingPath)
    }
    
    func decode(_ type: UInt8.Type) throws -> UInt8 {
        try value.decode(type, codingPath: codingPath)
    }
    
    func decode(_ type: UInt16.Type) throws -> UInt16 {
        try value.decode(type, codingPath: codingPath)
    }
    
    func decode(_ type: UInt32.Type) throws -> UInt32 {
        try value.decode(type, codingPath: codingPath)
    }
    
    func decode(_ type: UInt64.Type) throws -> UInt64 {
        try value.decode(type, codingPath: codingPath)
    }
}
