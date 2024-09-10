//
//  Company.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//

import Foundation

struct Company: Codable {
    let name, catchPhrase, bs: String?
    
    init(name: String? = "Nama", catchPhrase: String? = "Nama", bs: String? = "Nama") {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
}
