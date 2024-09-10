//
//  Address.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//

import Foundation

struct Address: Codable {
    let street, suite, city, zipcode: String?
    let geo: Geo?
    
    init(street: String?, suite: String?, city: String?, zipcode: String?, geo: Geo? = Geo.init()) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
    }
    
    static func MockAddress() -> Address {
        return Address.init(street: "Jalan", suite: "Block", city: "Kota", zipcode: "Kode Pos")
    }
}
