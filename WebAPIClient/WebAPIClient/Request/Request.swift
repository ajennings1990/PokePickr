//
//  Request.swift
//  WebAPIClient
//
//  Created by Andy Jennings on 21/11/2019.
//  Copyright © 2019 Andy Jennings. All rights reserved.
//

import Foundation

/// Conform to this protocol to define routes to be used with `WebAPIClient`.
public protocol Request {
  /// https://pokeapi.co/api/v2
  var baseURL: String { get }

  /// https://pokeapi.co/api/v2 **/pokemon/400**
  var path: String? { get }

  /// **GET**
  var method: HTTPMethod { get }

  /// Adds a query parameter to the URL
  var queryParameters: [String: String]? { get }
}

public enum HTTPMethod: String {
  case options = "OPTIONS"
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}
