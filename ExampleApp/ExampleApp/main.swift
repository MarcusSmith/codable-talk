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
    
    enum CodingKeys: String, CodingKey {
        case host = "DB_HOST"
        case port = "DB_PORT"
        case database = "DB_NAME"
        case username = "DB_USERNAME"
        case password = "DB_PASSWORD"
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

let decoder = EnvironmentDecoder(environment: environment)
let config = try! AppConfig(from: decoder)

print(config)
