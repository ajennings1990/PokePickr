import Foundation
import UIKit

struct PokemonGameInfo {
  
  let name: String?
  let number: String
  let pokemonImage: UIImage?
  let typeImages: [UIImage]?
  
  init(name: String?, pokemonNumber: Int, image: UIImage?) {
    self.name = name
    self.number = "\(pokemonNumber)"
    self.pokemonImage = image
    self.typeImages = []
//    self.typeImages = serverResponse.types.compactMap {
//      PokemonTypeImage(rawValue: $0.type.name ?? "")?.get() ?? .add
//    }
  }
  
}
