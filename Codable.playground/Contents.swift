import Foundation

let jsonData = """
{
  "id": 1,
  "name": "Codable Deep Dive",
  "speaker": "Marcus Smith",
  "tags": ["Codable", "Swift"]
}
""".data(using: .utf8)!

struct Tags: Codable {
    private var set: Set<String>

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        set = Set<String>()
        while !container.isAtEnd {
            set.insert(try container.decode(String.self))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try set.forEach { try container.encode($0) }
    }
}

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
    let tags: Tags
}

let decoder = JSONDecoder()
let talk = try! decoder.decode(Talk.self, from: jsonData)
