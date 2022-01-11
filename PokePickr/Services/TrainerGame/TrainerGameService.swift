import Foundation
import UIKit

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
        
        let url = URL(string: serverResponse.sprites.other.officialArtwork.frontDefault ?? "")

//        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data: data ?? Data())
//        }
        
        let gameInfo = PokemonGameInfo(
          name: serverResponse.species.name,
          pokemonNumber: randomNumber,
          image: image
        )
        completion(.success(gameInfo))
      } else if case .failure(let error) = response.result {
        completion(.failure(error))
      } else {
        completion(.failure(APIError.notReachable))
      }
    }
  }
  
  private func handleErrorResult<T>(result: Result<T, APIError>) -> Error {
    if case let .failure(error) = result {
      return error
    } else {
      return APIError.notReachable
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
