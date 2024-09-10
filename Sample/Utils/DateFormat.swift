//
//  DateFormat.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//
import Foundation

extension String {
    func parseDate(formatAPI: String, formatDisplay: String) -> String{
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = formatAPI
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = formatDisplay
            return outputFormatter.string(from: date)
        }
        return "-"
    }
}
