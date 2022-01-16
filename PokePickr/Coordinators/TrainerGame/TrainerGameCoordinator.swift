import UIKit

protocol TrainerGameCoordinatorDelegate: AnyObject {
  func trainerGameCoordinatorCompleted(_ coordinator: TrainerGameCoordinator)
}

class TrainerGameCoordinator: CoordinatorAutoCleanable {
  
  // MARK: - Internal Members
  
  var children: [String: Coordinator] = [:]
  weak var delegate: TrainerGameCoordinatorDelegate?
  let navigationController: UINavigationController
 
  let selectionTotal: Int
  lazy var selections: [PokemonGameInfo] = []
  
  let trainerGameService: TrainerGameService
  
  // MARK: - Lifecycle

  init(
    selectionTotal: Int,
    trainerGameService: TrainerGameService,
    navigationController: UINavigationController,
    delegate: TrainerGameCoordinatorDelegate
  ) {
    self.selectionTotal = selectionTotal
    self.trainerGameService = trainerGameService
    self.navigationController = navigationController
    self.delegate = delegate
  }
  
  func start() {
    let trainerGameViewController = TrainerGameViewController(delegate: self)
    navigationController.pushViewController(trainerGameViewController, animated: true)
  }
  
  // MARK: - Game State Handlers
  
  func loadPokemonData(for viewController: TrainerGameViewController) {
    viewController.pokemonInfo = []
    
    Task(priority: .userInitiated, operation: {
      let firstResponse = await trainerGameService.getRandomPokemon()
      let firstInfo = try? firstResponse.get()
      
      let secondResponse = await trainerGameService.getRandomPokemon()
      let secondInfo = try? secondResponse.get()
      
      if let firstInfo = firstInfo {
        updateUI(on: viewController, with: firstInfo)
      }
      if let secondInfo = secondInfo {
        updateUI(on: viewController, with: secondInfo)
      }
    })
  }
  
  private func updateUI(on viewController: TrainerGameViewController, with info: PokemonGameInfo) {
    DispatchQueue.main.async {
      viewController.updatePokemonInfo(info)
    }
  }
  
  // MARK: - Result Handlers
  
  func calculateResult(for viewController: TrainerGameViewController) {
    let loadingAlert = UIAlertController(title: "Calculating Result...", message: nil, preferredStyle: .alert)
    viewController.present(loadingAlert, animated: true, completion: nil)
    
    var allTypes: [PokemonType] = []
    selections.forEach({ allTypes.append(contentsOf: $0.types ?? [] )})
    
    let counts = allTypes.reduce(into: [:]) { $0[$1, default: 0] += 1 }
    let finalType = counts.first(where: { $0.value == counts.values.max() })?.key

    loadingAlert.dismiss(animated: true) {
      let resultAlert = UIAlertController(
        title: "Result",
        message: "\nYour specialist type is \(finalType?.rawValue ?? "")\n",
        preferredStyle: .alert
      )
      resultAlert.addAction(.init(title: "Ok", style: .default, handler: { [weak self] _ in
        self?.resultCompleted()
      }))
      viewController.present(resultAlert, animated: true, completion: nil)
    }
  }
  
  private func resultCompleted() {
    delegate?.trainerGameCoordinatorCompleted(self)
  }
}
