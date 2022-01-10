import Foundation

protocol TrainerGameService {
  func getRandomPokemon(_ completion: @escaping (Result<PokemonGameInfo, Error>) -> Void)
//  func getTypeInfo(_ type: PokemonType)
}

class DefaultTrainerGameService: TrainerGameService {
  
  // MARK: - Private Members
  
   private let pokemonInfoRepository: PokemonInfoRepository
  // private let imageRepository: ImageRepository
  
  // MARK: - Lifecycle
  
  init(pokemonInfoRepository: PokemonInfoRepository) {
    self.pokemonInfoRepository = pokemonInfoRepository
  }
  
  // MARK: - TrainerGameService
  
  func getRandomPokemon(_ completion: @escaping (Result<PokemonGameInfo, Error>) -> Void) {
    let randomNumber = Int.random(in: 1...898)
    
    pokemonInfoRepository.getPokemon(number: randomNumber) { response in
      if let serverResponse = try? response.result.get() {
        let gameInfo = PokemonGameInfo(serverResponse: serverResponse)
        completion(.success(gameInfo))
      }
    }
  }
  
}

import WebAPIClient

protocol PokemonInfoRepository {
  func getPokemon(number: Int, completion: @escaping (APIResponse<GetPokemonResponse>) -> Void)
}

class DefaultPokemonInfoRepository: PokemonInfoRepository {
  
  // MARK: - PokemonInfoRepository
  
  func getPokemon(number: Int, completion: @escaping (APIResponse<GetPokemonResponse>) -> Void) {
    WebAPIClient.send(
      Route.getPokemonInfo(number: number),
      completion: completion
    )
  }
  
}
