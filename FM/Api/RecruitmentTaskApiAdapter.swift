//
//  TasksDataProvider.swift
//  FM
//
//  Created by Łukasz Łuczak on 01/09/2021.
//

import Foundation

typealias DataApiAdapterProtocolGetDataCompletionHandler = ([DataItemDTO]) -> Void

protocol DataApiAdapterProtocol {
    func getData(completion: @escaping DataApiAdapterProtocolGetDataCompletionHandler)
}

class RecruitmentTaskApiAdapter: DataApiAdapterProtocol {
    private let api: ApiProtocol
    
    init(api: ApiProtocol) {
        self.api = api
    }
    
    func getData(completion: @escaping DataApiAdapterProtocolGetDataCompletionHandler) {
        api.downloadData { returnedTasks in
            guard let returnedTasks = returnedTasks else {
                completion([])
                return
            }
            
            let dtos = returnedTasks
                .map { $0.mapToRecruitmentTaskDTO() }
                .sorted(by: {$0.orderId < $1.orderId})
            
            completion(dtos)
        }
    }
}
