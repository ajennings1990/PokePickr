//
//  APIError.swift
//  WebAPIClient
//
//  Created by Andy Jennings on 21/11/2019.
//  Copyright © 2019 Andy Jennings. All rights reserved.
//

import Foundation

public enum APIError: Error {
  case notReachable
  case timeout
  case serialization
  case invalidURL
  case message(String)
  case unknown(Error)
}

extension APIError {

  public var userMessage: String {
    switch self {
    case .notReachable:
      return "We were unable to connect to the server, please check your internet connection"
    case .timeout:
      return "Your request timed out, please check your internet connection speed"
    case .serialization:
      return "A unexpected error occured, please try again later"
    case .invalidURL:
      return "There was an error attempting to connect to the chosen URL, please try again later"
    case .message(let message):
      return message
    case .unknown:
      return "There was an unknown error, please try again"
    }
  }

  public var failureReason: String? {
    switch self {
    case .notReachable:
      return "The reachability check failed"
    case .timeout:
      return "The request timed out"
    case .serialization:
      return "We were unable to serialize either the request or the response"
    case .invalidURL:
      return "The URL attempting to be connected to was invalid"
    case .message(let message):
      return message
    case .unknown(let error):
      return error.localizedDescription
    }
  }

}
