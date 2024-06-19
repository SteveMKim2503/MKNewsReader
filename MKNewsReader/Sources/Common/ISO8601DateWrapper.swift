//
//  ISO8601DateWrapper.swift
//  MKNewsReader
//
//  Created by MK on 6/18/24.
//

import Foundation

@propertyWrapper
struct ISO8601DateWrapper: Codable {
    var wrappedValue: Date?
    
    init(from decoder: Decoder) {
        do {
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            let formatter = ISO8601DateFormatter()
            wrappedValue = formatter.date(from: dateString)
        } catch {
            wrappedValue = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        if let date = wrappedValue {
            let dateString = ISO8601DateFormatter.string(from: date, timeZone: TimeZone.current)
            try container.encode(dateString)
        } else {
            try container.encodeNil()
        }
    }
}
