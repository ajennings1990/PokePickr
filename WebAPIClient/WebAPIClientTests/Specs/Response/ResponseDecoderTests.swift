//
//  ResponseDecoderTests.swift
//  WebAPIClientTests
//
//  Created by Andy Jennings on 22/11/2019.
//  Copyright © 2019 Andy Jennings. All rights reserved.
//

import XCTest

@testable import WebAPIClient

class ResponseDecoderTests: XCTestCase {
  
  var subject: ResponseDecoder!
  
  override func setUp() {
    super.setUp()
    subject = ResponseDecoder()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  private var json: [String: Any] {
    return [
      "id": 101,
      "testString": "Test String"
    ]
  }
  
  // MARK: - Succcess
  
  func test_decode_successResponse_correctJSON_returnsCorrectResponse() {
    // Arrange
    let data = try! JSONSerialization.data(withJSONObject: json,
                                           options: .prettyPrinted)
    let request = MockRequest()
    let response = APIResponse<Data>(result: .success(data))
    
    // Act
    let apiResponse: APIResponse<MockDecodable> = subject.decode(request: request,
                                                                 response: response)
    
    // Assert
    let mappedObject = try! apiResponse.result.get()

    XCTAssertEqual(mappedObject.id, 101)
    XCTAssertEqual(mappedObject.testString, "Test String")
  }
  
  func test_decode_successResponse_incorrectJSON_returnsCorrectError() {
    // Arrange
    let data = try! JSONSerialization.data(withJSONObject: ["hello": "goodbye"],
                                           options: .prettyPrinted)
    let request = MockRequest()
    let response = APIResponse<Data>(result: .success(data))
    
    // Act
    let apiResponse: APIResponse<MockDecodable> = subject.decode(request: request,
                                                                 response: response)
    
    // Assert
    if case .failure(let error) = apiResponse.result {
      XCTAssertEqual(error.failureReason, APIError.serialization.failureReason)
    }
  }
  
  // MARK: - Failure & Message
  
  func test_decode_failureResponse_withMessage_returnsCorrectResponse() {
    // Arrange
    let request = MockRequest()
    let expectedMessage = "Test Message"
    let response = APIResponse<Data>(result: .failure(.message(expectedMessage)))
    
    // Act
    let apiResponse: APIResponse<MockDecodable> = subject.decode(request: request,
                                                                 response: response)
    
    // Assert
    if case .failure(.message(let messageString)) = apiResponse.result {
      XCTAssertEqual(messageString, expectedMessage)
    }
  }
  
  // MARK: - Failure & Error
  
  func test_decode_failureResponse_withError_returnsCorrectResponse() {
    // Arrange
    let request = MockRequest()
    let expectedError = APIError.notReachable
    let response = APIResponse<Data>(result: .failure(expectedError))
    
    // Act
    let apiResponse: APIResponse<MockDecodable> = subject.decode(request: request,
                                                                 response: response)
    
    // Assert
    if case .failure(let error) = apiResponse.result {
      XCTAssertEqual(error.failureReason, expectedError.failureReason)
    }
  }
}

struct MockDecodable: Codable {
  let id: Int
  let testString: String
}
