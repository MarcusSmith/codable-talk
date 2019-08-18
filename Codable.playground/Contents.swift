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
}

let decoder = JSONDecoder()
let talk = try! decoder.decode(Talk.self, from: jsonData)
