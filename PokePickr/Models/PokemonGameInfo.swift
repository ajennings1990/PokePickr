import Foundation
import UIKit

struct PokemonGameInfo {
  
  let name: String?
  let number: String
  let pokemonImage: UIImage?
  let types: [PokemonType]?
  
  init(name: String?, pokemonNumber: Int, image: UIImage?, types: [PokemonType]) {
    self.name = name
    self.number = "\(pokemonNumber)"
    self.pokemonImage = image
    self.types = types
  }
  
}
