//
//  TaskExtensions.swift
//  FMTests
//
//  Created by Łukasz Łuczak on 03/09/2021.
//

import Foundation

import XCTest
@testable import FM

class TaskTests: XCTestCase {
    func testRemoveURLFromDescriptionShouldRemoveURLFromDescription() {
        let task1 = RecruitmentTask(orderId: 1, title: "", description: "Corned beef shoulder frankfurter\thttps://faxzero.com", imageURL: "", modificationDate: Date())
        let task2 = RecruitmentTask(orderId: 2, title: "", description: "Corned beef shoulder frankfurter \thttps://faxzero.com/", imageURL: "", modificationDate: Date())
        let task3 = RecruitmentTask(orderId: 3, title: "", description: "Corned beef shoulder frankfurter\thttps://faxzero.com/site", imageURL: "", modificationDate: Date())
        
        XCTAssertEqual("Corned beef shoulder frankfurter", task1.removeURLFromDescription())
        XCTAssertEqual("Corned beef shoulder frankfurter ", task2.removeURLFromDescription())
        XCTAssertEqual("Corned beef shoulder frankfurter", task3.removeURLFromDescription())
    }
    
    func testMapToTaskDTO() {
        let task = RecruitmentTask(orderId: 1, title: "title 1", description: "Corned beef shoulder frankfurter\thttps://faxzero.com", imageURL: "img", modificationDate: Date())
        let taskDTO = task.mapToRecruitmentTaskDTO()
        XCTAssertEqual(task.orderId, taskDTO.orderId)
        XCTAssertEqual(task.title, taskDTO.title)
        XCTAssertEqual("Corned beef shoulder frankfurter", taskDTO.description)
        XCTAssertEqual(task.imageURL, taskDTO.imageURL)
    }
    
    func testFormatModificationDate() {
        let task = RecruitmentTask(orderId: 1, title: "", description: "", imageURL: "", modificationDate: DateHelper.from(year: 2021, month: 9, day: 6))
        
        XCTAssertEqual("2021-09-06", task.formatModificationDate())
    }
}
