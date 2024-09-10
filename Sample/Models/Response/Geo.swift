//
//  Geo.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//

import Foundation

struct Geo: Codable {
    let lat, lng: String?
    
    init(lat: String? = "0.0", lng: String? = "0.0") {
        self.lat = lat
        self.lng = lng
    }
}
