//
//  Api.swift
//  FM
//
//  Created by Łukasz Łuczak on 01/09/2021.
//

import Foundation

struct RecruitmentTask: Codable {
    let orderId: Int
    let title: String
    let description: String
    let imageURL: String
    let modificationDate: Date
    
    init(orderId: Int, title: String, description: String, imageURL: String, modificationDate: Date) {
        self.orderId = orderId
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.modificationDate = modificationDate
    }
    
    enum CodingKeys: String, CodingKey {
        case orderId = "orderId"
        case title = "title"
        case description = "description"
        case imageURL = "image_url"
        case modificationDate = "modificationDate"
    }
}

extension RecruitmentTask {
    func mapToRecruitmentTaskDTO() -> RecruitmentTaskDTO {
        let description = removeURLFromDescription()
        let modificationDate = formatModificationDate()
        
        return RecruitmentTaskDTO(orderId: self.orderId, title: self.title, description: description, imageURL: self.imageURL, modificationDate: modificationDate)
    }
    
    func removeURLFromDescription() -> String {
        if let index = (self.description.range(of: "\thttp")?.lowerBound) {
            return String(self.description.prefix(upTo: index))
        }
        return self.description
    }
    
    func formatModificationDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: self.modificationDate)
    }
}
