//
//  RESTResponse.swift
//  WebAPIClient
//
//  Created by Andy Jennings on 21/11/2019.
//  Copyright © 2019 Andy Jennings. All rights reserved.
//

import Foundation

struct RESTResponse {
  let request: URLRequest?
  let response: URLResponse?
  let data: Data?
  let result: Result<Data, Error>
}

extension RESTResponse {

  internal func toAPIResponse() -> APIResponse<Data> {
    return APIResponse(request: request,
                       response: response,
                       data: data,
                       result: result.toAPIResult())
  }

}

extension Result where Success == Data {

  fileprivate func toAPIResult() -> Result<Data, APIError> {
    switch self {
    case .success(let data):
      return .success(data)
    case .failure(let error as APIError):
      return .failure(error)
    case .failure(let error as RESTError):
      return .failure(convertedRESTError(error))
    case .failure(let error):
      return .failure(.unknown(error))
    }
  }

  private func convertedRESTError(_ restError: RESTError) -> APIError {
    switch restError {
    case .notReachable:
      return .notReachable
    case .timeout:
      return .timeout
    case .unknown(let error):
      return .unknown(error)
    }
  }

}
