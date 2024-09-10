//
//  DropDown.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//

import Foundation

struct DropDown: Codable, Identifiable {
    var id = UUID()
    let label: String
    let value: String
}
