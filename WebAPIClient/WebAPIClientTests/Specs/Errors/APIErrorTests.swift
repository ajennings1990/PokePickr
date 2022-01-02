//
//  APIErrorTests.swift
//  WebAPIClientTests
//
//  Created by Andy Jennings on 22/11/2019.
//  Copyright © 2019 Andy Jennings. All rights reserved.
//

import XCTest

@testable import WebAPIClient

class APIErrorTests: XCTestCase {
  
  func test_notReachable_hasCorrectUserMessage() {
    // Arrange
    let expectedMessage = "We were unable to connect to the server, please check your internet connection"
    
    // Act
    let subject = APIError.notReachable
    
    // Assert
    XCTAssertEqual(subject.userMessage, expectedMessage)
  }
  
  func test_notReachable_hasCorrectFailureReason() {
    // Arrange
    let expectedReason = "The reachability check failed"
    
    // Act
    let subject = APIError.notReachable
    
    // Assert
    XCTAssertEqual(subject.failureReason, expectedReason)
  }
  
  func test_timeout_hasCorrectUserMessage() {
    // Arrange
    let expectedMessage = "Your request timed out, please check your internet connection speed"
    
    // Act
    let subject = APIError.timeout
    
    // Assert
    XCTAssertEqual(subject.userMessage, expectedMessage)
  }
  
  func test_timeout_hasCorrectFailureReason() {
    // Arrange
    let expectedReason = "The request timed out"
    
    // Act
    let subject = APIError.timeout
    
    // Assert
    XCTAssertEqual(subject.failureReason, expectedReason)
  }
  
  func test_serialization_hasCorrectUserMessage() {
    // Arrange
    let expectedMessage = "A unexpected error occured, please try again later"
    
    // Act
    let subject = APIError.serialization
    
    // Assert
    XCTAssertEqual(subject.userMessage, expectedMessage)
  }
  
  func test_serialization_hasCorrectFailureReason() {
    // Arrange
    let expectedReason = "We were unable to serialize either the request or the response"
    
    // Act
    let subject = APIError.serialization
    
    // Assert
    XCTAssertEqual(subject.failureReason, expectedReason)
  }
  
  func test_invalidURL_hasCorrectUserMessage() {
    // Arrange
    let expectedMessage = "There was an error attempting to connect to the chosen URL, please try again later"
    
    // Act
    let subject = APIError.invalidURL
    
    // Assert
    XCTAssertEqual(subject.userMessage, expectedMessage)
  }
  
  func test_invalidURL_hasCorrectFailureReason() {
    // Arrange
    let expectedReason = "The URL attempting to be connected to was invalid"
    
    // Act
    let subject = APIError.invalidURL
    
    // Assert
    XCTAssertEqual(subject.failureReason, expectedReason)
  }
  
  func test_message_hasCorrectUserMessage() {
    // Arrange
    let expectedMessage = "Test Message"
    
    // Act
    let subject = APIError.message(expectedMessage)
    
    // Assert
    XCTAssertEqual(subject.userMessage, expectedMessage)
  }
  
  func test_message_hasCorrectFailureReason() {
    // Arrange
    let expectedReason = "Test Reason"
    
    // Act
    let subject = APIError.message(expectedReason)
    
    // Assert
    XCTAssertEqual(subject.failureReason, expectedReason)
  }
  
  func test_unknown_hasCorrectUserMessage() {
    // Arrange
    let expectedMessage = "There was an unknown error, please try again"
    
    // Act
    let subject = APIError.unknown(GenericError())
    
    // Assert
    XCTAssertEqual(subject.userMessage, expectedMessage)
  }
  
  func test_unknown_hasCorrectFailureReason() {
    // Arrange
    let expectedDescription = "Test"
    let error = NSError(domain: "Domain", code: 0, userInfo: [
      NSLocalizedDescriptionKey: expectedDescription
    ])
    
    // Act
    let subject = APIError.unknown(error)
    
    // Assert
    XCTAssertEqual(subject.failureReason, expectedDescription)
  }
}
