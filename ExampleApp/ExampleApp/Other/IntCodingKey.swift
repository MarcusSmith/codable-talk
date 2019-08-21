import Foundation

struct IntCodingKey: CodingKey {
    init(value: Int) {
        self.intValue = value
        self.stringValue = "\(value)"
    }
    
    // CodingKey
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) {
        guard let intValue = Int(stringValue) else {
            return nil
        }
        
        self.intValue = intValue
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = "\(intValue)"
    }
}
