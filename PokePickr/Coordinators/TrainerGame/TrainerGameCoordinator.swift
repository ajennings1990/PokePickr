import UIKit

protocol TrainerGameCoordinatorDelegate: AnyObject {
  func trainerGameCoordinatorCompleted(_ coordinator: MainViewCoordinator)
}

class TrainerGameCoordinator: CoordinatorAutoCleanable {
  
  // MARK: - Internal Members
  
  var children: [String: Coordinator] = [:]
  weak var delegate: TrainerGameCoordinatorDelegate?
  let navigationController: UINavigationController
  
  // MARK: - Private Members
  
  private lazy var selections: [PokemonGameInfo] = []
  
  private let selectionTotal: Int
  private let trainerGameService: TrainerGameService
  
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
  
  private func loadPokemonData(for viewController: TrainerGameViewController) {
    viewController.pokemonInfo = []
    
    trainerGameService.getRandomPokemon { response in
      guard let info = try? response.get() else { return }
      DispatchQueue.main.async {
        viewController.pokemonInfo.append(info)
      }
    }
    
    trainerGameService.getRandomPokemon { response in
      guard let info = try? response.get() else { return }
      DispatchQueue.main.async {
        viewController.pokemonInfo.append(info)
      }
    }
  }
  
  private func calculateResult(for viewController: TrainerGameViewController) {
    let loadingAlert = UIAlertController(title: "Calculating Result...", message: nil, preferredStyle: .alert)
    viewController.present(loadingAlert, animated: true, completion: nil)
    
    var allTypes: [PokemonType] = []
    selections.forEach({ allTypes.append(contentsOf: $0.types ?? [] )})
    
    let counts = allTypes.reduce(into: [:]) { $0[$1, default: 0] += 1 }
    let finalType = counts.first(where: { $0.value == counts.values.max() })?.key

    loadingAlert.dismiss(animated: true) { [weak navigationController] in
      let resultAlert = UIAlertController(
        title: "Result",
        message: "\nYour specialist type is \(finalType?.rawValue ?? "")\n",
        preferredStyle: .alert
      )
      resultAlert.addAction(.init(title: "Ok", style: .default, handler: { action in
        navigationController?.popToRootViewController(animated: true)
      }))
      viewController.present(resultAlert, animated: true, completion: nil)
    }
  }
  
}

extension TrainerGameCoordinator: TrainerGameViewControllerDelegate {
  
  func viewControllerViewWillAppear(_ viewController: TrainerGameViewController) {
    loadPokemonData(for: viewController)
  }
  
  func viewControllerDidMakeSelection(_ viewController: TrainerGameViewController, selection: PokemonGameInfo) {
    guard selections.count < selectionTotal - 1 else {
      calculateResult(for: viewController)
      return
    }
    selections.append(selection)
    loadPokemonData(for: viewController)
  }
  
}
