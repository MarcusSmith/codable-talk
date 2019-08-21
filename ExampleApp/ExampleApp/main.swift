import Foundation

/*
DB_HOST=localhost
DB_PORT=5432
DB_NAME=database
DB_USERNAME=Admin
DB_PASSWORD=Password
API_KEYS=asdfasdfasdf,123412341234
*/
let environment = ProcessInfo.processInfo.environment

struct DatabaseConfig: Decodable {
    let host: String
    let port: Int
    let database: String
    let username: String
    let password: String?
    
    enum ExampleCodingKeys: String, CodingKey {
        case host = "DB_HOST"
        case port = "DB_PORT"
        case database = "DB_NAME"
        case username = "DB_USERNAME"
        case password = "DB_PASSWORD"
    }
    
    enum OtherCodingKeys: String, CodingKey {
        case host = "DATABASE_HOST"
        case port = "DATABASE_PORT"
        case database = "DATABASE_NAME"
        case username = "DATABASE_USERNAME"
        case password = "DATABASE_PASSWORD"
    }
    
    init(from decoder: Decoder) throws {
        let processName = decoder.userInfo[CodingUserInfoKey.processName] as? String
        let processID = decoder.userInfo[CodingUserInfoKey.processIdentifier] as? Int32
        
        print("Decoding database from process \(processID ?? 0) \(processName ?? "")")
        
        if processName == "ExampleApp" {
            let container = try decoder.container(keyedBy: ExampleCodingKeys.self)
            host = try container.decode(String.self, forKey: .host)
            port = try container.decode(Int.self, forKey: .port)
            database = try container.decode(String.self, forKey: .database)
            username = try container.decode(String.self, forKey: .username)
            password = try container.decodeIfPresent(String.self, forKey: .password)
        } else {
            let container = try decoder.container(keyedBy: OtherCodingKeys.self)
            host = try container.decode(String.self, forKey: .host)
            port = try container.decode(Int.self, forKey: .port)
            database = try container.decode(String.self, forKey: .database)
            username = try container.decode(String.self, forKey: .username)
            password = try container.decodeIfPresent(String.self, forKey: .password)
        }
    }
}

struct AppConfig: Decodable {
    let database: DatabaseConfig
    let apiKeys: [String]
    
    enum CodingKeys: String, CodingKey {
        case database = "doesn't matter"
        case apiKeys = "API_KEYS"
    }
}

let decoder = EnvironmentDecoder()
let config = try! AppConfig(from: decoder)

print(config)
