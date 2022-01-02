//
//  URLRequestBuilderTests.swift
//  WebAPIClientTests
//
//  Created by Andy Jennings on 22/11/2019.
//  Copyright © 2019 Andy Jennings. All rights reserved.
//

import XCTest

@testable import WebAPIClient

class URLRequestBuilderTests: XCTestCase {
  
  var subject: URLRequestBuilder!
  var mockRequest: MockRequest!
  
  override func setUp() {
    super.setUp()
    mockRequest = MockRequest(baseURL: "https://api.icndb.com")
    subject = URLRequestBuilder()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func test_buildURLRequest_invalidRequest_throws() {
    // Arrange
    let request = MockRequest()
    XCTAssertThrowsError(try subject.buildURLRequest(request: request))
  }
  
  func test_buildURLRequest_validRequest_doesNotThrow() {
    XCTAssertNoThrow(try! subject.buildURLRequest(request: mockRequest))
  }
  
  func test_buildURLRequest_validRequest_returnsCorrectValues() {
    // Arrange
    let expectedBaseUrl = "base_url"
    let expectedPath = "test_path"
    let expectedQueries = ["query1": "one", "query2": "two"]
    let expectedHeaders = Constants.Headers.common
    let expectedMethod = HTTPMethod.get
      
    mockRequest.baseURL = expectedBaseUrl
    mockRequest.path = expectedPath
    mockRequest.queryParameters = expectedQueries
    mockRequest.method = expectedMethod
    
    // Act
    let request = try! subject.buildURLRequest(request: mockRequest)
    
    // Assert
    let components = request.url?.absoluteString.components(separatedBy: "/")
    let baseUrl = components?.first
    let path = components?.last?.components(separatedBy: "?").first
    let queries = components?.last?.components(separatedBy: "?").last
    
    XCTAssertEqual(baseUrl, expectedBaseUrl)
    XCTAssertEqual(path, expectedPath)
    XCTAssertTrue(queries!.contains("query2=two"))
    XCTAssertTrue(queries!.contains("query1=one"))
    XCTAssertEqual(request.httpMethod, expectedMethod.rawValue)
    XCTAssertEqual(request.allHTTPHeaderFields, expectedHeaders)
  }
}
