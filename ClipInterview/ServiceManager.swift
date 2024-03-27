//
//  ServiceManager.swift
//  ClipInterview
//
//  Created by Sergio Andres Rodriguez Castillo on 27/03/24.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case invalidData
}

protocol ServiceManagerProtocol {
    func requestDataFromURL<T: Decodable>(_ urlString: String, completionHandler: @escaping (Result<T, Error>) -> Void)
}

class ServiceManager: ServiceManagerProtocol {
    func requestDataFromURL<T: Decodable>(_ urlString: String, completionHandler: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(NetworkError.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
            }
            
            guard let data = data else {
                completionHandler(.failure(NetworkError.invalidData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(response))
            } catch let error {
                completionHandler(.failure(error))
            }
        }
        .resume()
    }
}
