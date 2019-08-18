import Foundation

let jsonData = """
{
  "name": "Codable Deep Dive",
  "speaker": "Marcus Smith"
}
""".data(using: .utf8)!

struct Talk: Codable {
    let name: String
    let speaker: String
}

let codableTalk = try! JSONDecoder().decode(Talk.self, from: jsonData)

let arTalk = Talk(name: "Build immersive experiences with ARKit and CoreLocation", speaker: "Eric Internicola")

let data = try! JSONEncoder().encode(arTalk)
let string = String(bytes: data, encoding: .utf8)
