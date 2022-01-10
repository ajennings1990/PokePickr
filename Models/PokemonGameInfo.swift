import Foundation
import UIKit

struct PokemonGameInfo {
  
  let name: String?
  let number: String?
  let typeImages: [UIImage]?
  
  init(serverResponse: GetPokemonResponse) {
    self.name = serverResponse.species.name
    self.number = "2"
    self.typeImages = serverResponse.types.compactMap {
      PokemonTypeImage(rawValue: $0.type.name ?? "")?.get() ?? .add
    }
  }
  
}
