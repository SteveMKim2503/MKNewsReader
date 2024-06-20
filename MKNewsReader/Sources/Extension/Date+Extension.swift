//
//  Date+Extension.swift
//  MKNewsReader
//
//  Created by MK on 6/20/24.
//

import Foundation

extension Date {
    
    var koreanTimeString: String {
        var formatStyle = Date.FormatStyle.dateTime
        formatStyle.timeZone = TimeZone(abbreviation: "KST")!
        formatStyle.locale = Locale(identifier: "ko_KR")
        return formatted(formatStyle)
    }
}
