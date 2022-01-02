//
//  GenericError.swift
//  WebAPIClient
//
//  Created by Andy Jennings on 21/11/2019.
//  Copyright © 2019 Andy Jennings. All rights reserved.
//

import Foundation

struct GenericError: Error {
  public var localizedDescription: String {
    return "Something went wrong. Please try again."
  }
}
