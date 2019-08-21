import Foundation

struct StringUnkeyedContainer: UnkeyedDecodingContainer {
    let initialValue: String?
    let values: [String]
    let userInfo: [CodingUserInfoKey : Any]
    
    init(value: String?, userInfo: [CodingUserInfoKey : Any], codingPath: [CodingKey]) {
        self.initialValue = value
        self.values = value?.components(separatedBy: ",") ?? []
        self.userInfo = userInfo
        self.codingPath = codingPath
    }
    
    // Convenience
    mutating func next() -> StringSingleValueContainer {
        let value = values[currentIndex]
        let path = codingPath + [IntCodingKey(value: currentIndex)]
        
        let container = StringSingleValueContainer(
            value: value,
            userInfo: userInfo,
            codingPath: path
        )
        currentIndex += 1
        
        return container
    }
    
    // UnkeyedDecodingContainer
    let codingPath: [CodingKey]
    var currentIndex: Int = 0
    var count: Int? {
        return values.count
    }
    var isAtEnd: Bool {
        return currentIndex >= values.count
    }
    
    mutating func decodeNil() throws -> Bool {
        guard initialValue == nil else {
            throw DecodingError.typeMismatch(
                NSNull.self,
                DecodingError.Context(
                    codingPath: codingPath,
                    debugDescription: "Expected nil but received \(initialValue!)"
                )
            )
        }
        
        return true
    }
    
    mutating func decode(_ type: Bool.Type) throws -> Bool {
        return try next().decode(type)
    }
    
    mutating func decode(_ type: String.Type) throws -> String {
        return try next().decode(type)
    }
    
    mutating func decode(_ type: Double.Type) throws -> Double {
        return try next().decode(type)
    }
    
    mutating func decode(_ type: Float.Type) throws -> Float {
        return try next().decode(type)
    }
    
    mutating func decode(_ type: Int.Type) throws -> Int {
        return try next().decode(type)
    }
    
    mutating func decode(_ type: Int8.Type) throws -> Int8 {
        return try next().decode(type)
    }
    
    mutating func decode(_ type: Int16.Type) throws -> Int16 {
        return try next().decode(type)
    }
    
    mutating func decode(_ type: Int32.Type) throws -> Int32 {
        return try next().decode(type)
    }
    
    mutating func decode(_ type: Int64.Type) throws -> Int64 {
        return try next().decode(type)
    }
    
    mutating func decode(_ type: UInt.Type) throws -> UInt {
        return try next().decode(type)
    }
    
    mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        return try next().decode(type)
    }
    
    mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        return try next().decode(type)
    }
    
    mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        return try next().decode(type)
    }
    
    mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        return try next().decode(type)
    }
    
    mutating func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        return try next().decode(type)
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        throw DecodingError.typeMismatch(
            Dictionary<String, String>.self,
            DecodingError.Context(
                codingPath: codingPath,
                debugDescription: "Cannot have nested environment in array"
            )
        )
    }
    
    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        throw DecodingError.typeMismatch(
            Array<String>.self,
            DecodingError.Context(
                codingPath: codingPath,
                debugDescription: "Cannot have array nested in another array"
            )
        )
    }
    
    mutating func superDecoder() throws -> Decoder {
        return StringValueDecoder(
            value: initialValue,
            userInfo: userInfo,
            codingPath: codingPath
        )
    }
}
