//
//  RESTError.swift
//  WebAPIClient
//
//  Created by Andy Jennings on 21/11/2019.
//  Copyright © 2019 Andy Jennings. All rights reserved.
//

import Foundation

public enum RESTError: Error {
  case notReachable
  case timeout
  case unknown(Error)
}
