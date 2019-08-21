import Foundation

extension CodingUserInfoKey {
    static let processName = CodingUserInfoKey(rawValue: "ProcessInfo.processName")!;
    static let processIdentifier = CodingUserInfoKey(rawValue: "ProcessInfo.processIdentifier")!;
}
