import Foundation

import WebAPIClient

/// Mapping of Raw JSON Response from Server
struct GetPokemonResponse: Codable {
  
  struct Species: Codable {
    let name: String
    let url: String
  }

  // MARK: -

  struct Sprites: Codable {
    
    struct Other: Codable {
      
      enum CodingKeys: String, CodingKey {
        case home = "home"
        case officialArtwork = "official-artwork"
      }
      
      struct Home: Codable {
        let frontDefault: String?
        let frontShiny: String?
      }
      
      struct OfficialArtwork: Codable {
        let frontDefault: String?
      }
      
      let home: Home
      let officialArtwork: OfficialArtwork
      
    }
    
    let frontDefault: String?
    let frontShiny: String?
    let other: Other
    
  }
  
  
  // MARK: -

  struct SpeciesType: Codable {
    
    struct `Type`: Codable {
      let name: String?
      let url: String?
    }
    
    let type: `Type`
    
  }
  
  // MARK: -
  
  let species: Species
  let sprites: Sprites
  let types: [SpeciesType]
  
}
