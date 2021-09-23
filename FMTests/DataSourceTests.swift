//
//  TaskListDataSourceTests.swift
//  FMTests
//
//  Created by Łukasz Łuczak on 31/08/2021.
//

import XCTest
@testable import FM

class DataSourceTests: XCTestCase {
    func testShouldLoadData() {
        let tasks = [
            RecruitmentTaskDTO(orderId: 1, title: "", description: "", imageURL: "", modificationDate: "2021-09-06")
        ]
        
        let apiAdapter = ApiAdapter(items: tasks)
        let dataSource = DataSource(apiAdapter: apiAdapter)
        dataSource.loadData { }
        XCTAssertEqual(1, dataSource.count())
        
        apiAdapter.add(item: RecruitmentTaskDTO(orderId: 2, title: "", description: "", imageURL: "", modificationDate: "2021-09-06"))
        XCTAssertEqual(1, dataSource.count())
        dataSource.loadData { }
        XCTAssertEqual(2, dataSource.count())
        XCTAssertEqual(1, dataSource.item(at: 0).orderId)
        XCTAssertEqual(2, dataSource.item(at: 1).orderId)
    }
    
    func testItemShouldReturnCorrectDTO() {
        let tasks = [
            RecruitmentTaskDTO(orderId: 1, title: "", description: "", imageURL: "", modificationDate: "2021-09-06"),
            RecruitmentTaskDTO(orderId: 3, title: "", description: "", imageURL: "", modificationDate: "2021-09-06"),
            RecruitmentTaskDTO(orderId: 2, title: "", description: "", imageURL: "", modificationDate: "2021-09-06")
        ]
        
        let dataSource = DataSource(apiAdapter: ApiAdapter(items: tasks))
        dataSource.loadData { }
        XCTAssertEqual(1, dataSource.item(at: 0).orderId)
        XCTAssertEqual(3, dataSource.item(at: 1).orderId)
        XCTAssertEqual(2, dataSource.item(at: 2).orderId)
    }
    
    class ApiAdapter: DataApiAdapterProtocol {
        private var items: [RecruitmentTaskDTO]
        
        init(items: [RecruitmentTaskDTO]) {
            self.items = items
        }
        
        func getData(completion: @escaping ([DataItemDTO]) -> Void) {
            completion(items)
        }
        
        func add(item: RecruitmentTaskDTO) {
            items.append(item)
        }
    }
}
