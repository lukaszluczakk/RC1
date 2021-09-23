//
//  MockTaskApi.swift
//  FM
//
//  Created by Łukasz Łuczak on 05/09/2021.
//

import Foundation

final class UITestRecruitmentTaskApi: ApiProtocol {
    func downloadData(completion: @escaping ApiProtocolDownloadDataCompletionHandlerType) {
        let task1 = RecruitmentTask(orderId: 1, title: "Title 1", description: "Corned beef shoulder frankfurter\thttps://faxzero.com", imageURL: "https://i.picsum.photos/id/163/200/300.jpg?hmac=MHvt2U1kS_umJxJUqatJt-p78ljmX5Hxct3dxWTZRHA", modificationDate: DateHelper.from(year: 2021, month: 9, day: 6))
        
        let task2 = RecruitmentTask(orderId: 2, title: "Title 2", description: "Corned beef shoulder frankfurter\thttps://faxzero.com", imageURL: "https://i.picsum.photos/id/163/200/300.jpg?hmac=MHvt2U1kS_umJxJUqatJt-p78ljmX5Hxct3dxWTZRHA", modificationDate: DateHelper.from(year: 2021, month: 9, day: 6))
        
        completion([task1, task2])
    }
}
