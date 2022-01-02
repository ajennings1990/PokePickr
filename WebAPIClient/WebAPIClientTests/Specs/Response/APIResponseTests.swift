//
//  APIResponseTests.swift
//  WebAPIClientTests
//
//  Created by Andy Jennings on 22/11/2019.
//  Copyright © 2019 Andy Jennings. All rights reserved.
//

import XCTest

@testable import WebAPIClient

class APIResponseTests: XCTestCase {
  
  var subject: APIResponse<Data>!
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func test_initWithRequest_initializesCorrectly() {
    // Arrange
    let expectedURL = URL(string: "https://www.test.com")!
    let expectedRequest = URLRequest(url: expectedURL)
    let expectedResponse = URLResponse(url: expectedURL,
                                       mimeType: nil,
                                       expectedContentLength: 1,
                                       textEncodingName: nil)
    let expectedData = "test_string".data(using: .utf8)!
    let expectedResult: Result<Data, APIError> = .success(expectedData)
    
    // Act
    subject = APIResponse<Data>.init(request: expectedRequest,
                                     response: expectedResponse,
                                     data: expectedData,
                                     result: expectedResult)
    
    // Assert
    XCTAssertEqual(subject.request, expectedRequest)
    XCTAssertEqual(subject.response, expectedResponse)
    XCTAssertEqual(subject.data, expectedData)
    XCTAssertEqual(try! subject.result.get(), try! expectedResult.get())
  }
  
  func test_initWithRESTResponse_initializesCorrectly() {
    // Arrange
    let expectedURL = URL(string: "https://www.test.com")!
    let expectedRequest = URLRequest(url: expectedURL)
    let expectedResponse = URLResponse(url: expectedURL,
                                       mimeType: nil,
                                       expectedContentLength: 1,
                                       textEncodingName: nil)
    let expectedData = "test_string".data(using: .utf8)!
    let expectedResult: Result<Data, APIError> = .success(expectedData)
    let initialResult: Result<Data, Error> = .success(expectedData)
    
    let restResponse = RESTResponse(request: expectedRequest,
                                        response: expectedResponse,
                                        data: expectedData,
                                        result: initialResult)
    
    // Act
    subject = APIResponse<Data>.init(response: restResponse,
                                     result: expectedResult)
    
    // Assert
    XCTAssertEqual(subject.request, expectedRequest)
    XCTAssertEqual(subject.response, expectedResponse)
    XCTAssertEqual(subject.data, expectedData)
    XCTAssertEqual(try! subject.result.get(), try! expectedResult.get())
  }
  
}
