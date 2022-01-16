import WebAPIClient

public protocol PokemonInfoRepository {
  func getPokemon(number: Int) async -> APIResponse<GetPokemonResponse>
}

public class DefaultPokemonInfoRepository: PokemonInfoRepository {
  
  // MARK: - PokemonInfoRepository
  
  public func getPokemon(number: Int) async -> APIResponse<GetPokemonResponse> {
    await WebAPIClient.send(Route.getPokemonInfo(number: number))
  }
  
}
