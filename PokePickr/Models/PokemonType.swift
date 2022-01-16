//
//  PokemonType.swift
//  PokePickr
//
//  Created by Andrew Jennings on 09/01/2022.
//

import Foundation
import UIKit

public enum PokemonType: String, CaseIterable, Codable {
  case Normal
  case Fighting
  case Flying
  case Poison
  case Ground
  case Rock
  case Bug
  case Ghost
  case Steel
  case Fire
  case Water
  case Grass
  case Electric
  case Psychic
  case Ice
  case Dragon
  case Dark
  case Fairy
  
  func getImage() -> UIImage {
    UIImage(named: self.rawValue) ?? .add
  }
}

extension CaseIterable where Self: Equatable {

    var index: Self.AllCases.Index? {
        return Self.allCases.firstIndex { self == $0 }
    }
  
}
