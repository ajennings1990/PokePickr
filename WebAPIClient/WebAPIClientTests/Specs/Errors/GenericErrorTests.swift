//
//  GenericErrorTests.swift
//  WebAPIClientTests
//
//  Created by Andy Jennings on 22/11/2019.
//  Copyright © 2019 Andy Jennings. All rights reserved.
//

import XCTest

@testable import WebAPIClient

class GenericErrorTests: XCTestCase {

  func test_init_initializesWithCorrectLocalizedDescription() {
    // Arrange
    let expectedDescription = "Something went wrong. Please try again."
    
    // Act
    let subject = GenericError()
    
    // Assert
    XCTAssertEqual(subject.localizedDescription, expectedDescription)
  }

}
