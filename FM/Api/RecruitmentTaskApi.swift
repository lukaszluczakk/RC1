//
//  Api.swift
//  FM
//
//  Created by Łukasz Łuczak on 01/09/2021.
//

import Foundation

typealias ApiProtocolDownloadDataCompletionHandlerType = ([RecruitmentTask]?) -> Void

protocol ApiProtocol {
    func downloadData(completion: @escaping ApiProtocolDownloadDataCompletionHandlerType)
}

final class RecruitmentTaskApi: ApiProtocol {
    private static let url = URL(string: "encrypted_url")!
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func downloadData(completion: @escaping ApiProtocolDownloadDataCompletionHandlerType) {
        networkManager.fetchData(for: Self.url) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    let returnedTasks = try decoder.decode([RecruitmentTask].self, from: data)
                    completion(returnedTasks)
                } catch let error {
                    print("Error while decoding data. \(error)")
                    completion(nil)
                }
            case .failure(let error):
                print("Error while downloading data. \(error)")
                completion(nil)
            }
        }
    }
}
