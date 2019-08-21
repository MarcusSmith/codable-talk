import Foundation

struct StringValueDecoder: Decoder {
    var value: String?
    
    // Decoder
    var userInfo: [CodingUserInfoKey : Any]
    var codingPath: [CodingKey]
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        throw DecodingError.typeMismatch(
            Dictionary<String, String>.self,
            DecodingError.Context(
                codingPath: codingPath,
                debugDescription: "Expected [String: String] but received String"
            )
        )
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        return StringUnkeyedContainer(
            value: value,
            userInfo: userInfo,
            codingPath: codingPath
        )
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        return StringSingleValueContainer(
            value: value,
            userInfo: userInfo,
            codingPath: codingPath
        )
    }
}
