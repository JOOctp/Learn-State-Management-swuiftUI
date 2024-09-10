//
//  BaseResponse.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//

import Foundation

public struct BaseResponse<T: Codable>: Decodable {
    public let status: Bool?
    public let data: T?
}
