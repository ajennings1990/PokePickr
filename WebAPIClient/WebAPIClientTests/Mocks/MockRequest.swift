//
//  MockRequest.swift
//  WebAPIClientTests
//
//  Created by Andy Jennings on 22/11/2019.
//  Copyright © 2019 Andy Jennings. All rights reserved.
//

import Foundation

import WebAPIClient

class MockRequest: Request {
  
  var baseURL: String

  var path: String?
  
  var method: HTTPMethod
  
  var queryParameters: [String : String]?
    
  public init(baseURL: String = "",
              path: String? = nil,
              method: HTTPMethod = .get,
              queryParameters: [String: String]? = nil) {
    self.baseURL = baseURL
    self.path = path
    self.method = method
    self.queryParameters = queryParameters
  }
}
