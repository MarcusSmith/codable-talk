import Foundation

struct EnvironmentDecoder: Decoder {
    var environment: [String: String]
    
    init(environment: [String: String],
         userInfo: [CodingUserInfoKey : Any] = [:],
         codingPath: [CodingKey] = [])
    {
        self.environment = environment
        self.userInfo = userInfo
        self.codingPath = codingPath
    }
    
    init(processInfo: ProcessInfo = ProcessInfo.processInfo) {
        self.environment = processInfo.environment
        self.userInfo = [
            CodingUserInfoKey.processName: processInfo.processName,
            CodingUserInfoKey.processIdentifier: processInfo.processIdentifier
        ]
        self.codingPath = []
    }
    
    // Decoder
    var userInfo: [CodingUserInfoKey : Any]
    var codingPath: [CodingKey]
    
    // Keyed Container
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        return KeyedDecodingContainer(
            EnvironmentKeyedDecodingContainer<Key>(
                environment: environment,
                userInfo: userInfo,
                codingPath: codingPath
            )
        )
    }
    
    // Unkeyed Container
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        throw DecodingError.typeMismatch(
            Array<Any>.self,
            DecodingError.Context(
                codingPath: codingPath,
                debugDescription: "Expected Array but received Dictionary"
            )
        )
    }
    
    // Single Value Container
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        throw DecodingError.typeMismatch(
            String.self,
            DecodingError.Context(
                codingPath: codingPath,
                debugDescription: "Expected String but received Dictionary"
            )
        )
    }
}
