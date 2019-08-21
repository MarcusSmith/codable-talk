import Foundation

let jsonData = """
{
  "id": 1,
  "name": "Codable Deep Dive",
  "speaker": "Marcus Smith",
}
""".data(using: .utf8)!

struct Talk: Codable {
    struct Identifier: Codable {
        let value: Int
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            value = try container.decode(Int.self)
        }
        
        mutating func encode(from encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(value)
        }
    }
    
    let id: Identifier?
    let name: String
    let speaker: String
}

let decoder = JSONDecoder()
let talk = try! decoder.decode(Talk.self, from: jsonData)
