import WebAPIClient

protocol PokemonInfoRepository {
  func getPokemon(number: Int) async -> APIResponse<GetPokemonResponse>
}

class DefaultPokemonInfoRepository: PokemonInfoRepository {
  
  // MARK: - PokemonInfoRepository
  
  func getPokemon(number: Int) async -> APIResponse<GetPokemonResponse> {
    await WebAPIClient.send(Route.getPokemonInfo(number: number))
  }
  
}
