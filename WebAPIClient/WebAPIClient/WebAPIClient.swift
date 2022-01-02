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
  public static func send<T: Decodable>(_ request: Request,
                                        completion: @escaping (APIResponse<T>) -> Void) {
    send(request) { (response: APIResponse<Data>) in
      let returnableResponse: APIResponse<T> = self.responseDecoder.decode(request: request,
                                                                           response: response)
      completion(returnableResponse)
    }
  }
  
  private static func send(_ request: Request,
                           completion: @escaping (APIResponse<Data>) -> Void) {
    do {
      // add Reachability checks here
      let urlRequest = try urlBuilder.buildURLRequest(request: request)
      return perform(urlRequest: urlRequest) { response in
        let apiResponse = response.toAPIResponse()
        completion(apiResponse)
      }
    } catch let error as APIError {
      completion(APIResponse(result: .failure(error)))
    } catch {
      completion(APIResponse(result: .failure(.unknown(error))))
    }
  }
  
  private static func perform(urlRequest: URLRequest,
                              completion: @escaping (RESTResponse) -> Void) {
    let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
      completion(restResponse(request: urlRequest,
                              data: data,
                              response: response,
                              error: error))
    }
    task.resume()
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
