//
//  ResponseDecoder.swift
//  WebAPIClient
//
//  Created by Andy Jennings on 21/11/2019.
//  Copyright © 2019 Andy Jennings. All rights reserved.
//

import Foundation

struct ResponseDecoder {

  func decode<T: Decodable>(request: Request,
                            response: APIResponse<Data>) -> APIResponse<T> {
    let result: Result<T, APIError>
    switch response.result {
    case .success(let data):
      result = decodedResult(request: request, data: data)
    case .failure(.message(let string)):
      result = .failure(.message(string))
    case .failure(let error):
      result = .failure(error)
    }
    return APIResponse(request: response.request,
                       response: response.response,
                       data: response.data,
                       result: result)
  }

  private func decodedResult<T: Decodable>(request: Request,
                                           data: Data) -> Result<T, APIError> {
    let result: Result<T, APIError>
    let decoder = JSONDecoder()
    do {
      let objects = try decoder.decode(T.self, from: data)
      result = .success(objects)
    } catch {
      result = .failure(APIError.serialization)
    }
    return result
  }

}

