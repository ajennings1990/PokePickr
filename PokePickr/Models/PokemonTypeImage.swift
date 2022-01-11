//
//  PokemonType.swift
//  PokePickr
//
//  Created by Andrew Jennings on 09/01/2022.
//

import Foundation
import UIKit

enum PokemonTypeImage: String, Codable {
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
  
  func get() -> UIImage {
    switch self {
    case .Grass: return #imageLiteral(resourceName: "Grass_Type_Icon")
    default:
      return UIImage.add
    }
  }
}
