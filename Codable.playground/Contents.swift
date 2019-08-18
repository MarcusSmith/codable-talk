import Foundation

let jsonData = """
{
  "id": 1,
  "name": "Codable Deep Dive",
  "speaker": "Marcus Smith",
  "startTime": "2019-08-27T11:30:00-0600",
  "endTime": "2019-08-27T12:15:00-0600"
}
""".data(using: .utf8)!

struct Talk: Codable {
    let id: Int?
    let name: String
    let speaker: String
    let startTime: Date
    let endTime: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case speaker
        case startTime
        case endTime
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        speaker = try container.decode(String.self, forKey: .speaker)
        startTime = try container.decode(Date.self, forKey: .startTime)
        endTime = try container.decode(Date.self, forKey: .endTime)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(speaker, forKey: .speaker)
        try container.encode(startTime, forKey: .startTime)
        try container.encode(endTime, forKey: .endTime)
    }
}

let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601
let talk = try! decoder.decode(Talk.self, from: jsonData)

let encoder = JSONEncoder()
encoder.dateEncodingStrategy = .iso8601
let newData = try! encoder.encode(talk)
let string = String(bytes: newData, encoding: .utf8)
