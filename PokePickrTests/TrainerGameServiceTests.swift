import XCTest

import WebAPIClient

@testable import PokePickr

class TrainerGameServiceTests: XCTestCase {

  var subject: TrainerGameService!
  
  var stubRepository: StubPokemonInfoRepository!
  
  // MARK: - Setup
  
  override func setUp() {
    super.setUp()
    
    stubRepository = StubPokemonInfoRepository()
    subject = DefaultTrainerGameService(pokemonInfoRepository: stubRepository)
  }
  
  override func tearDown() {
    stubRepository.stubGetPokemonResponse = nil
  }
  
  // MARK: - Tests

  func test_getRandomPokemon_successResponse_returnsCorrectInfo() async {
    // Arrange
    stubRepository.stubGetPokemonResponse = APIResponse(
      request: nil,
      response: nil,
      data: nil,
      result: .success(getPokemonResponse)
    )
    
    // Act
    let response = await subject.getRandomPokemon()
    let info = try! response.get()
    
    // Assert
    XCTAssertEqual(info.name, "name")
    XCTAssertLessThan(info.number, "898")
    XCTAssertGreaterThan(info.number, "0")
    XCTAssertEqual(info.pokemonImage, UIImage(named: "frontDefault"))
    XCTAssertEqual(info.types, [PokemonType.Grass])
  }
  
}

extension TrainerGameServiceTests {
  
  var getPokemonResponse: GetPokemonResponse {
    GetPokemonResponse(
      species: .init(name: "name", url: "url"),
      sprites: .init(
        frontDefault: "front",
        frontShiny: "frontShiny",
        other: .init(
          home: .init(
            frontDefault: "frontHome",
            frontShiny: "frontHomeShint"
          ),
          officialArtwork: .init(
            frontDefault: "frontDefault"
          )
        )
      ),
      types: [
        .init(
          type: .init(name: "Grass", url: "typeUrl")
        )
      ]
    )
  }
  
}

class StubPokemonInfoRepository: PokemonInfoRepository {
  
  var stubGetPokemonResponse: APIResponse<GetPokemonResponse>?
  func getPokemon(number: Int) async -> APIResponse<GetPokemonResponse> {
    if let response = stubGetPokemonResponse {
      return response
    } else {
      return APIResponse(request: nil, response: nil, data: nil, result: .failure(APIError.notReachable))
    }
  }
  
}
