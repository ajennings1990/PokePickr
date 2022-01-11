import Foundation
import UIKit

struct PokemonGameInfo {
  
  let name: String?
  let number: String?
  let typeImages: [UIImage]?
  
  init(serverResponse: GetPokemonResponse, pokemonNumber: Int) {
    self.name = serverResponse.species.name
    self.number = "\(pokemonNumber)"
    self.typeImages = []
//    self.typeImages = serverResponse.types.compactMap {
//      PokemonTypeImage(rawValue: $0.type.name ?? "")?.get() ?? .add
//    }
  }
  
}
