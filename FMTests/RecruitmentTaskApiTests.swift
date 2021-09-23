//
//  RecruitmentTaskApiTests.swift
//  FMTests
//
//  Created by Łukasz Łuczak on 06/09/2021.
//

import Foundation
import XCTest

@testable import FM

class RecruitmentTaskApiTests: XCTestCase {
    func testDownloadDataShouldEncodeData() {
        let networkManager = NetworkManagerWithCorrectData()
        let recruitmentApi = RecruitmentTaskApi(networkManager: networkManager)
        let exp = expectation(description: "Wait for data")
        recruitmentApi.downloadData { returnedTasks in
            guard let returnedTasks = returnedTasks else { return }

            XCTAssertEqual(1, returnedTasks.count)
            let task = returnedTasks[0]

            XCTAssertEqual(1, task.orderId)
            XCTAssertEqual("Title 1", task.title)
            XCTAssertEqual("Corned beef shoulder frankfurter\thttps://faxzero.com", task.description)
            XCTAssertEqual("img", task.imageURL)
            XCTAssertEqual(DateHelper.from(year: 2021, month: 9, day: 6), task.modificationDate)
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func testDownloadDataShouldHandleEmptyDataFromAPI() {
        let networkManager = NetworkManagerWithEmptyData()
        let recruitmentApi = RecruitmentTaskApi(networkManager: networkManager)
        let exp = expectation(description: "Wait for data")
        recruitmentApi.downloadData { returnedTasks in
            XCTAssertNil(returnedTasks)
            exp.fulfill()
        }

        wait(for: [exp], timeout: 0.1)
    }
    
    func testDownloadDataShouldHandleInvalidDataFromAPI() {
        let networkManager = NetworkManagerWithInvalidData()
        let recruitmentApi = RecruitmentTaskApi(networkManager: networkManager)
        let exp = expectation(description: "Wait for data")
        recruitmentApi.downloadData { returnedTasks in
            XCTAssertNil(returnedTasks)
            exp.fulfill()
        }

        wait(for: [exp], timeout: 0.1)
    }
    
    class NetworkManagerWithCorrectData: NetworkManagerProtocol {
        
        func fetchData(for url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
            let task = RecruitmentTask(orderId: 1, title: "Title 1", description: "Corned beef shoulder frankfurter\thttps://faxzero.com", imageURL: "img", modificationDate: DateHelper.from(year: 2021, month: 9, day: 6))
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(dateFormatter)
            let encoded = try! encoder.encode([task])
            completion(.success(encoded))
        }
    }
    
    class NetworkManagerWithEmptyData: NetworkManagerProtocol {
        func fetchData(for url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
            completion(.failure(NetworkError.emptyData))
        }
    }
    
    class NetworkManagerWithInvalidData: NetworkManagerProtocol {
        func fetchData(for url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
            let task = MockRecruitmentTask()
            let encoded = try! JSONEncoder().encode([task])
            completion(.success(encoded))
        }
    }
    
    class MockRecruitmentTask: Codable {
        let orderId: String = "test"
        
        enum CodingKeys: String, CodingKey {
            case orderId = "orderId"
        }
    }
}
