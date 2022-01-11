import Foundation

import WebAPIClient

enum Route: Equatable {
  case getPokemonInfo(number: Int)
}

extension Route: Request {
  
  var baseURL: String {
    return "https://pokeapi.co/api/v2"
  }
  
  var path: String? {
    switch self {
    case .getPokemonInfo(let number):
      return "/pokemon/\(number)"
    }
  }
  
  var method: HTTPMethod {
    .get
  }
  
  var queryParameters: [String : String]? {
    return nil
  }
  
}
