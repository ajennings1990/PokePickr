//
//  APIResponse.swift
//  WebAPIClient
//
//  Created by Andy Jennings on 21/11/2019.
//  Copyright © 2019 Andy Jennings. All rights reserved.
//

import Foundation

//public typealias WebAPIResponse = APIResponse
public struct APIResponse<T> {
  /// The URL request sent to the server.
  public let request: URLRequest?

  /// The server's response to the URL request.
  public let response: URLResponse?

  /// The data returned by the server.
  public let data: Data?

  /// The result of the request
  public internal(set) var result: Result<T, APIError>

  public init(request: URLRequest? = nil,
              response: URLResponse? = nil,
              data: Data? = nil,
              result: Result<T, APIError>) {
    self.request = request
    self.response = response
    self.data = data
    self.result = result
  }

  internal init(response: RESTResponse,
                result: Result<T, APIError>) {
    self.request = response.request
    self.response = response.response
    self.data = response.data
    self.result = result
  }

}

