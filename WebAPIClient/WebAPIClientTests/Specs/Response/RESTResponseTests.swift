//
//  RESTResponseTests.swift
//  WebAPIClientTests
//
//  Created by Andy Jennings on 22/11/2019.
//  Copyright © 2019 Andy Jennings. All rights reserved.
//

import XCTest

@testable import WebAPIClient

class RESTResponseTests: XCTestCase {
  
  var subject: RESTResponse!
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: - Success
  
  func test_toAPIResponse_successResult_returnsCorrectValues() {
    // Arrange
    let expectedURL = URL(string: "https://www.test.com")!
    let expectedRequest = URLRequest(url: expectedURL)
    let expectedResponse = URLResponse(url: expectedURL,
                                       mimeType: nil,
                                       expectedContentLength: 1,
                                       textEncodingName: nil)
    let expectedString = "test_string"
    let expectedData = expectedString.data(using: .utf8)!
    let expectedResult: Result<Data, Error> = .success(expectedData)
    
    subject = RESTResponse(request: expectedRequest,
                           response: expectedResponse,
                           data: expectedData,
                           result: expectedResult)
    
    // Act
    let apiResponse = subject.toAPIResponse()
    
    // Assert
    XCTAssertEqual(apiResponse.request, expectedRequest)
    XCTAssertEqual(apiResponse.response, expectedResponse)
    XCTAssertEqual(apiResponse.data, expectedData)
    XCTAssertEqual(try! apiResponse.result.get(), try! expectedResult.get())
  }
 
  // MARK: - Failure & RESTError
  
  func test_toAPIResponse_failureResult_notReachableRESTError_returnsCorrectResult() {
    // Arrange
    subject = RESTResponse.arrange(result: .failure(RESTError.notReachable))
    
    // Act
    let apiResponse = subject.toAPIResponse()
    
    // Assert
    if case .failure(let error) = apiResponse.result {
      XCTAssertEqual(error.failureReason, APIError.notReachable.failureReason)
    }
  }
  
  func test_toAPIResponse_failureResult_timeoutESTError_returnsCorrectResult() {
    // Arrange
    subject = RESTResponse.arrange(result: .failure(RESTError.timeout))
    
    // Act
    let apiResponse = subject.toAPIResponse()
    
    // Assert
    if case .failure(let error) = apiResponse.result {
      XCTAssertEqual(error.failureReason, APIError.timeout.failureReason)
    }
  }
  
  func test_toAPIResponse_failureResult_unknownESTError_returnsCorrectResult() {
    // Arrange
    let error = NSError(domain: "domain", code: 0, userInfo: [
      NSLocalizedDescriptionKey: "The operation couldn’t be completed. (WebAPIClient.APIError error 1.)"
    ])
    subject = RESTResponse.arrange(result: .failure(RESTError.unknown(error)))
    
    // Act
    let apiResponse = subject.toAPIResponse()
    
    // Assert
    if case .failure(let error) = apiResponse.result {
      XCTAssertEqual(error.failureReason, APIError.unknown(error).failureReason)
    }
  }
  
  // MARK: - Failure & APIError
  
  func test_toAPIResponse_failureResult_timeoutAPIError_returnsCorrectResult() {
    // Arrange
    subject = RESTResponse.arrange(result: .failure(APIError.timeout))
    
    // Act
    let apiResponse = subject.toAPIResponse()
    
    // Assert
    if case .failure(let error) = apiResponse.result {
      XCTAssertEqual(error.failureReason, APIError.timeout.failureReason)
    }
  }
}

private extension RESTResponse {
  static func arrange(request: URLRequest? = nil,
                      response: URLResponse? = nil,
                      data: Data? = nil,
                      result: Result<Data, Error> = .success(Data())) -> RESTResponse {
    return RESTResponse(request: request,
                        response: response,
                        data: data,
                        result: result)
  }
}
