import Foundation
import UIKit

import WebAPIClient

protocol TrainerGameService {
  func getRandomPokemon() async -> Result<PokemonGameInfo, Error>
  //  func getTypeInfo(_ type: PokemonType)
}

class DefaultTrainerGameService: TrainerGameService {
  
  // MARK: - Private Members
  
  private let pokemonInfoRepository: PokemonInfoRepository
  
  // MARK: - Lifecycle
  
  init(pokemonInfoRepository: PokemonInfoRepository) {
    self.pokemonInfoRepository = pokemonInfoRepository
  }
  
  // MARK: - TrainerGameService
  
  func getRandomPokemon() async -> Result<PokemonGameInfo, Error> {
    let randomNumber = Int.random(in: 1...898)
    let response = await pokemonInfoRepository.getPokemon(number: randomNumber)
    
    if let serverResponse = try? response.result.get() {
      return await handleSuccessResponse(serverResponse, pokemonNumber: randomNumber)
    } else if case .failure(let error) = response.result {
      return .failure(error)
    } else {
      return .failure(APIError.notReachable)
    }
  }
  
  private func handleSuccessResponse(_ response: GetPokemonResponse, pokemonNumber: Int) async -> Result<PokemonGameInfo, Error> {
    guard let url = URL(string: response.sprites.other.officialArtwork.frontDefault ?? "") else {
      return .failure(APIError.serialization)
    }
    
    async let data = try? Data(contentsOf: url)
    let image = await UIImage(data: data ?? Data())
    let types = response.types.compactMap {
      PokemonType(rawValue: $0.type.name?.capitalized ?? "")
    }
    
    let gameInfo = PokemonGameInfo(
      name: response.species.name,
      pokemonNumber: pokemonNumber,
      image: image,
      types: types
    )
    return .success(gameInfo)
  }
  
}
