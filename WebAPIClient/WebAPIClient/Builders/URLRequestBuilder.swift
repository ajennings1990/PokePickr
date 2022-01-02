//
//  URLRequestBuilder.swift
//  WebAPIClient
//
//  Created by Andy Jennings on 21/11/2019.
//  Copyright © 2019 Andy Jennings. All rights reserved.
//

import Foundation

struct URLRequestBuilder {

  internal func buildURLRequest(request: Request) throws -> URLRequest {
    guard var url = URL(string: request.baseURL) else {
      throw APIError.invalidURL
    }
    addPath(from: request, to: &url)
    addQueries(from: request, to: &url)
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method.rawValue
    urlRequest.timeoutInterval = 60
    addHeaders(to: &urlRequest)
    
    return urlRequest
  }

  private func addPath(from request: Request, to url: inout URL) {
    url.appendPathComponent(request.path ?? "")
  }

  private func addQueries(from request: Request, to url: inout URL) {
    if let queryParameters = request.queryParameters,
       var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
      components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
      url = components.url ?? url
    }
  }

  private func addHeaders(to urlRequest: inout URLRequest) {
    urlRequest.allHTTPHeaderFields = Constants.Headers.common
  }

}
