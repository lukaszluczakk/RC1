//
//  ImageManager.swift
//  FM
//
//  Created by Łukasz Łuczak on 05/09/2021.
//

import Foundation
import UIKit

typealias ImageManagerGetImageCompletionHandlerType = (UIImage?) -> Void

protocol ImageManagerProtocol {
    func getImage(url: URL, completion: @escaping ImageManagerGetImageCompletionHandlerType)
}

class ImageManager: ImageManagerProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getImage(url: URL, completion: @escaping ImageManagerGetImageCompletionHandlerType) {
        networkManager.fetchData(for: url) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                completion(image)
            case .failure(let error):
                print("Error while downloading data. \(error)")
                completion(nil)
            }
        }
    }
    
}
