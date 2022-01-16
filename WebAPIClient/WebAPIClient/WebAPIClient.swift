//
//  WebAPIClient.swift
//  WebAPIClient
//
//  Created by Andy Jennings on 21/11/2019.
//  Copyright © 2019 Andy Jennings. All rights reserved.
//

import Foundation
import SystemConfiguration

public class WebAPIClient: NSObject {
  
  internal static let urlBuilder: URLRequestBuilder = URLRequestBuilder()
  internal static var responseDecoder: ResponseDecoder = ResponseDecoder()
  
  /**
   Performs a network request expecting a object value response.
   
   - parameter request: The route with which to build the request.
   - parameter completion: Closure to execute when the network request is complete.
   */
  public static func send<T: Decodable>(
    _ request: Request
  ) async -> APIResponse<T> {
    let response = await send(request)
    let returnableResponse: APIResponse<T> = responseDecoder.decode(request: request, response: response)
    return returnableResponse
  }
  
  private static func send(
    _ request: Request
  ) async -> APIResponse<Data> {
    do {
      // add Reachability checks here
      let urlRequest = try urlBuilder.buildURLRequest(request: request)
      let response = await perform(urlRequest: urlRequest)
      let apiResponse = response.toAPIResponse()
      return apiResponse
    } catch let error as APIError {
      return APIResponse(result: .failure(error))
    } catch {
      return APIResponse(result: .failure(.unknown(error)))
    }
  }
  
  private static func perform(
    urlRequest: URLRequest
  ) async -> RESTResponse {
    var dataResponse: (Data, URLResponse)
    
    do {
      if #available(iOS 15.0, *) {
        dataResponse = try await URLSession.shared.data(for: urlRequest, delegate: nil)
      } else {
        dataResponse = try await WebAPIClient.performLegacy(urlRequest: urlRequest)
      }
      return restResponse(request: urlRequest, data: dataResponse.0, response: dataResponse.1, error: nil)
    }
    catch {
      return restResponse(request: urlRequest, data: nil, response: nil, error: APIError.invalidURL)
    }
  }
  
  @available(iOS, deprecated: 15.0, message: "This extension is no longer necessary. Use API built into SDK")
  static func performLegacy(urlRequest: URLRequest) async throws -> (Data, URLResponse) {
    try await withCheckedThrowingContinuation { continuation in
      let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        guard let data = data, let response = response else {
          let error = error ?? URLError(.badServerResponse)
          return continuation.resume(throwing: error)
        }
        
        continuation.resume(returning: (data, response))
      }
      
      task.resume()
    }
  }
  
  private static func restResponse(request: URLRequest,
                                   data: Data?,
                                   response: URLResponse?,
                                   error: Error?) -> RESTResponse {
    var result: Swift.Result<Data, Error> = .failure(GenericError())
    if let data = data {
      result = .success(data)
    } else if let error = error {
      result = .failure(error)
    }
    return RESTResponse(request: request,
                        response: response,
                        data: data,
                        result: result)
  }
  
  
}
