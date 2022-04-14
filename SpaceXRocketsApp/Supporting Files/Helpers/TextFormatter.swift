//
//  TextFormatter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 12.04.2022.
//

import Foundation

final class TextFormatter {
    
    enum DateFormat: String {
        case yyyyMMdd = "yyyy-MM-dd"
        case MMddyyyy = "MM/dd/yyyy"
        case yyyyMMddTHHmmssZ = "yyyy-MM-dd'T'HH:mm:ssZ"
        case MMMMdyyyy = "MMMM d, yyyy"
    }
    
    static func convertDateFormat(date: String, from input: DateFormat, to output: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = input.rawValue
        
        let currentDate = formatter.date(from: date)
        formatter.dateFormat = output.rawValue
        
        let resultString = formatter.string(from: currentDate!)
        
        return resultString
    }
    
    static func roundNumberWithUnit(_ number: Int) -> String {
        let symbol = "$"
        let units = ["K", "M", "B", "T"]
        
        
        let num = Double(number)
        if (num < 1000.0) {
            return "\(symbol)\(num)"
        }
        
        let exp: Int = Int(log10(num) / 3.0)
        let roundedNum: Double = round(10 * num / pow(1000.0, Double(exp))) / 10
        
        return "\(symbol)\(roundedNum) \(units[exp-1])"
    }
}
