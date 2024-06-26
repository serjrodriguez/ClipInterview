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
    case invalidStatusCode
}

protocol URLSessionProtocol {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

protocol ServiceManagerProtocol {
    func requestDataFromURL<T: Decodable>(_ urlString: String, completionHandler: @escaping (Result<T, Error>) -> Void)
}

class ServiceManager: ServiceManagerProtocol {
    var session: URLSessionProtocol = URLSession.shared
    private var dataTask: URLSessionDataTask?
    
    func requestDataFromURL<T: Decodable>(_ urlString: String, completionHandler: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(NetworkError.badURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completionHandler(.failure(NetworkError.invalidStatusCode))
                return
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
        
        dataTask?.resume()
    }
}
