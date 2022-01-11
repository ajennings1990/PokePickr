import Foundation

import WebAPIClient

/// Mapping of Raw JSON Response from Server
struct GetPokemonResponse: Codable {

  /// General information about a Pokemon
  /// - name : String --- The Name of the Pokemon
  /// - url : String --- The Url String used to fetch info about this pokemon
  struct Species: Codable {
    let name: String
    let url: String
  }

  // MARK: -

  struct Sprites: Codable {
    
    struct Other: Codable {
      
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

  struct PokemonType: Codable {
    
    struct `Type`: Codable {
      let name: String?
      let url: String?
    }
    
    let type: `Type`
    
  }
  
  // MARK: -
  
  let species: Species
//  let sprites: Sprites
//  let types: [PokemonType]
  
}
