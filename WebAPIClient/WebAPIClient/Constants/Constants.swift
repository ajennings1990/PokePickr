//
//  Constants.swift
//  WebAPIClient
//
//  Created by Andy Jennings on 21/11/2019.
//  Copyright © 2019 Andy Jennings. All rights reserved.
//

import Foundation

struct Constants {

  struct Headers {
    static var common: [String: String] {
      return [
        "Content-Type": "application/json",
        "Accept": "application/json",
      ]
    }
  }

}

