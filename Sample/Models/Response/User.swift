//
//  User.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int?
    let name, username, email: String?
    let address: Address?
    let phone, website: String?
    let company: Company?
    
    init(id: Int? = -1, name: String? = "User", username: String? = "Username", email: String? = "email@email.com", address: Address?, phone: String? = "0812345678910", website: String? = "Hallo", company: Company?) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }
    
    static func MockUser() -> User {
        return User.init(address: Address.MockAddress(), company: Company.init())
    }
}
