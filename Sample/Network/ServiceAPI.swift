//
//  ServiceAPI.swift
//  Sample
//
//  Created by Jevon Putra on 10/09/24.
//

import Foundation

class ServiceAPI {
    func get<T: Decodable>(_ type: T.Type, url: URL?, completion: @escaping(Result<T, ErrorResponse>) -> Void){
        guard let url = url else {
            let error = ErrorResponse.badURL
            completion(Result.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: method(url: url, method: "GET")) { (data, response, error) in
            if let error = error as? URLError {
                completion(Result.failure(ErrorResponse.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200...209).contains(response.statusCode){
                completion(Result.failure(ErrorResponse.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(type.self, from: data)
                    completion(Result.success(result))
                } catch {
                    completion(Result.failure(ErrorResponse.parsing(error as? DecodingError)))
                }
            }
        }
        
        task.resume()
    }
    
    func put<T: Decodable>(_ type: T.Type, url: URL?, data: Data, completion: @escaping(Result<T, ErrorResponse>) -> Void){
        guard let url = url else {
            let error = ErrorResponse.badURL
            completion(Result.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: method(url: url, method: "PUT", data: data)) { (data, response, error) in
            if let error = error as? URLError {
                completion(Result.failure(ErrorResponse.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200...209).contains(response.statusCode){
                completion(Result.failure(ErrorResponse.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(type.self, from: data)
                    completion(Result.success(result))
                } catch {
                    completion(Result.failure(ErrorResponse.parsing(error as? DecodingError)))
                }
            }
        }
        
        task.resume()
    }
    
    private func method(url: URL, method: String, data: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.httpMethod = method
        if (data != nil) { request.httpBody = data }
        
        return request
    }
}
