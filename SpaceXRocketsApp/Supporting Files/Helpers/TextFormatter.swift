//
//  TextFormatter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 12.04.2022.
//

import Foundation

final class TextFormatter {
    
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
    
    static func convertDateFormat(from data: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let newDate = formatter.date(from: data)
        formatter.dateFormat = "MM/dd/yyyy"
        
        let resultString = formatter.string(from: newDate!)
        
        return resultString
    }
}
