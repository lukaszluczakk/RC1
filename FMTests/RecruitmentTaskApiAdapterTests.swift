//
//  TasksDataApiAdapterTests.swift
//  FMTests
//
//  Created by Łukasz Łuczak on 03/09/2021.
//

import Foundation
import XCTest

@testable import FM

class TasksDataApiAdapterTests: XCTestCase {
    func testGetDataShouldSortList() {
        let task1 = RecruitmentTask(orderId: 1, title: "", description: "", imageURL: "", modificationDate: Date())
        let task2 = RecruitmentTask(orderId: 2, title: "", description: "", imageURL: "", modificationDate: Date())
        let task3 = RecruitmentTask(orderId: 3, title: "", description: "", imageURL: "", modificationDate: Date())
        
        let api = Api(data: [task2, task3, task1])
        let apiAdapter = RecruitmentTaskApiAdapter(api: api)
        let exp = expectation(description: "wait for data")
        apiAdapter.getData { returnedTasks in
            guard returnedTasks.count == 3 else { return }
            
            XCTAssertEqual(1, returnedTasks[0].orderId)
            XCTAssertEqual(2, returnedTasks[1].orderId)
            XCTAssertEqual(3, returnedTasks[2].orderId)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func testGetDataShouldHandleNil() {
        let api = Api(data: nil)
        let apiAdapter = RecruitmentTaskApiAdapter(api: api)
        let exp = expectation(description: "wait for data")
        apiAdapter.getData { returnedTasks in
            XCTAssertEqual(0, returnedTasks.count)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func testGetDataShouldRemoveURLFromDescription(){
        let task = RecruitmentTask(orderId: 1, title: "", description: "Corned beef shoulder frankfurter\thttps://faxzero.com", imageURL: "", modificationDate: Date())
        
        let api = Api(data: [task])
        let apiAdapter = RecruitmentTaskApiAdapter(api: api)
        let exp = expectation(description: "wait for data")
        apiAdapter.getData { returnedTasks in
            guard returnedTasks.count == 1 else { return }
            
            XCTAssertEqual("Corned beef shoulder frankfurter", returnedTasks[0].description)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func testGetDataShouldFormatModificationDate(){
        let task = RecruitmentTask(orderId: 1, title: "", description: "", imageURL: "", modificationDate: DateHelper.from(year: 2021, month: 9, day: 6))
        
        let api = Api(data: [task])
        let apiAdapter = RecruitmentTaskApiAdapter(api: api)
        let exp = expectation(description: "wait for data")
        apiAdapter.getData { returnedTasks in
            guard returnedTasks.count == 1 else { return }
            
            XCTAssertEqual("2021-09-06", returnedTasks[0].modificationDate)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 0.1)
    }
    
    class Api: ApiProtocol {
        private let data: [RecruitmentTask]?
        
        init(data: [RecruitmentTask]?) {
            self.data = data
        }
        
        func downloadData(completion: @escaping ApiProtocolDownloadDataCompletionHandlerType) {
            completion(data)
        }
    }
}
