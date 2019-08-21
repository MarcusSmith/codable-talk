import Foundation

struct StringSingleValueContainer: SingleValueDecodingContainer {
    let value: String?
    let userInfo: [CodingUserInfoKey : Any]
    
    // Convenience
    private func unwrap<T>(transform: (String) -> T?) throws -> T {
        guard let value = value, value != "" else {
            throw DecodingError.keyNotFound(
                codingPath.last!,
                DecodingError.Context(
                    codingPath: codingPath,
                    debugDescription: "Key \(codingPath.last!.stringValue) not found"
                )
            )
        }
        
        guard let transformed = transform(value) else {
            throw DecodingError.typeMismatch(
                T.self,
                DecodingError.Context(
                    codingPath: codingPath,
                    debugDescription: "Expected \(T.self) but received \(value)"
                )
            )
        }
        
        return transformed
    }
    
    // SingleValueDecodingContainer
    let codingPath: [CodingKey]
    
    func decodeNil() -> Bool {
        return value == nil || value == ""
    }
    
    func decode(_ type: Bool.Type) throws -> Bool {
        return try unwrap { Bool($0) }
    }
    
    func decode(_ type: String.Type) throws -> String {
        return try unwrap { $0 }
    }
    
    func decode(_ type: Double.Type) throws -> Double {
        return try unwrap { Double($0) }
    }
    
    func decode(_ type: Float.Type) throws -> Float {
        return try unwrap { Float($0) }
    }
    
    func decode(_ type: Int.Type) throws -> Int {
        return try unwrap { Int($0) }
    }
    
    func decode(_ type: Int8.Type) throws -> Int8 {
        return try unwrap { Int8($0) }
    }
    
    func decode(_ type: Int16.Type) throws -> Int16 {
        return try unwrap { Int16($0) }
    }
    
    func decode(_ type: Int32.Type) throws -> Int32 {
        return try unwrap { Int32($0) }
    }
    
    func decode(_ type: Int64.Type) throws -> Int64 {
        return try unwrap { Int64($0) }
    }
    
    func decode(_ type: UInt.Type) throws -> UInt {
        return try unwrap { UInt($0) }
    }
    
    func decode(_ type: UInt8.Type) throws -> UInt8 {
        return try unwrap { UInt8($0) }
    }
    
    func decode(_ type: UInt16.Type) throws -> UInt16 {
        return try unwrap { UInt16($0) }
    }
    
    func decode(_ type: UInt32.Type) throws -> UInt32 {
        return try unwrap { UInt32($0) }
    }
    
    func decode(_ type: UInt64.Type) throws -> UInt64 {
        return try unwrap { UInt64($0) }
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        let decoder = StringValueDecoder(
            value: value,
            userInfo: userInfo,
            codingPath: codingPath
        )
        return try T.init(from: decoder)
    }
}
