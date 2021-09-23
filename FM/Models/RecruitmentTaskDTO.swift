//
//  TaskDTO.swift
//  FM
//
//  Created by Łukasz Łuczak on 03/09/2021.
//

import Foundation

protocol DataItemDTO {
    var orderId: Int { get }
    var title: String { get }
    var description: String { get }
    var imageURL: String { get }
    var modificationDate: String { get }
}

final class RecruitmentTaskDTO : DataItemDTO {
    let orderId: Int
    let title: String
    let description: String
    let imageURL: String
    let modificationDate: String
    
    init(orderId: Int, title: String, description: String, imageURL: String, modificationDate: String) {
        self.orderId = orderId
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.modificationDate = modificationDate
    }
}
