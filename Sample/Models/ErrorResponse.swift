//
//  ErrorResponse.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//

import Foundation

enum ErrorResponse: Error, CustomStringConvertible {
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing (DecodingError?)
    case unknown (Error)
    
    var localizedDescription: String {
        switch self {
        case .badURL, .parsing, .unknown:
            return "Sorry, something went wrong."
        case .badResponse(_):
            return "Sorry, the connection to our server failed."
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong"
        }
    }
    
    var description: String {
        switch self {
        case .unknown: return "Unknown error"
        case .badURL: return "Invalid url"
        case .url(let error): return error?.localizedDescription ?? "Url session error"
        case .parsing(let error): return "Parsing Error \(error?.localizedDescription ?? "")"
        case .badResponse(statusCode: let statusCode): return "Bad response with status code \(statusCode)"
        }
    }
}
