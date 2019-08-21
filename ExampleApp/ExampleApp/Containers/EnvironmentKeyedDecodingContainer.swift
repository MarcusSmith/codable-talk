import Foundation

struct EnvironmentKeyedDecodingContainer<Key: CodingKey> : KeyedDecodingContainerProtocol {
    let environment: [String: String]
    let userInfo: [CodingUserInfoKey : Any]
    
    // Convenience
    func container(forKey key: Key) -> StringSingleValueContainer {
        return StringSingleValueContainer(
            value: environment[key.stringValue],
            userInfo: userInfo, codingPath:
            codingPath + [key]
        )
    }
    
    // KeyedDecodingContainerProtocol
    let codingPath: [CodingKey]
    var allKeys: [Key] {
        return environment.keys.compactMap { Key(stringValue: $0) }
    }
    
    func contains(_ key: Key) -> Bool {
        return environment.keys.contains(key.stringValue)
    }
    
    func decodeNil(forKey key: Key) throws -> Bool {
        return container(forKey: key).decodeNil()
    }
    
    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        return try container(forKey: key).decode(type)
    }
    
    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        return try container(forKey: key).decode(type)
    }
    
    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        return try container(forKey: key).decode(type)
    }
    
    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        return try container(forKey: key).decode(type)
    }
    
    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        return try container(forKey: key).decode(type)
    }
    
    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        return try container(forKey: key).decode(type)
    }
    
    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        return try container(forKey: key).decode(type)
    }
    
    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        return try container(forKey: key).decode(type)
    }
    
    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        return try container(forKey: key).decode(type)
    }
    
    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        return try container(forKey: key).decode(type)
    }
    
    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        return try container(forKey: key).decode(type)
    }
    
    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        return try container(forKey: key).decode(type)
    }
    
    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        return try container(forKey: key).decode(type)
    }
    
    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        return try container(forKey: key).decode(type)
    }
    
    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
        if contains(key) {
            let valueDecoder = StringValueDecoder(
                value: environment[key.stringValue],
                userInfo: userInfo,
                codingPath: codingPath + [key]
            )
            return try T.init(from: valueDecoder)
        } else {
            let environmentDecoder = EnvironmentDecoder(
                environment: environment,
                userInfo: userInfo,
                codingPath: codingPath + [key]
            )
            return try T.init(from: environmentDecoder)
        }
    }
    
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        return KeyedDecodingContainer(
            EnvironmentKeyedDecodingContainer<NestedKey>(
                environment: environment,
                userInfo: userInfo,
                codingPath: codingPath + [key]
            )
        )
    }
    
    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        return StringUnkeyedContainer(
            value: environment[key.stringValue],
            userInfo: userInfo,
            codingPath: codingPath + [key]
        )
    }
    
    func superDecoder() throws -> Decoder {
        return EnvironmentDecoder(environment: environment)
    }
    
    func superDecoder(forKey key: Key) throws -> Decoder {
        return EnvironmentDecoder(environment: environment)
    }
}
