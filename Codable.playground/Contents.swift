import Foundation

let jsonData = """
{
  "id": 1,
  "name": "Codable Deep Dive",
  "speaker": "Marcus Smith",
}
""".data(using: .utf8)!

struct Talk: Codable {
    let id: Int?
    let name: String
    let speaker: String
}

let decoder = JSONDecoder()
let talk = try! decoder.decode(Talk.self, from: jsonData)
