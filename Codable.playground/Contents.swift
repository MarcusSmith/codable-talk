import Foundation

let jsonData = """
{
  "name": "Codable Deep Dive",
  "speaker": "Marcus Smith"
}
""".data(using: .utf8)!

struct Talk {
    let name: String
    let speaker: String
}
