//
//  NetworkManager.swift
//  FM
//
//  Created by Łukasz Łuczak on 04/09/2021.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchData(for url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

enum NetworkError: Error {
    case emptyData
    
    var errorDescription: String {
        switch self {
        case .emptyData: return "API returned empty data."
        }
    }
}

class NetworkManager: NetworkManagerProtocol {
    func fetchData(for url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
