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
  
  private let trainerGameService: TrainerGameService

  // MARK: - Lifecycle

  init(
    trainerGameService: TrainerGameService,
    navigationController: UINavigationController,
    delegate: TrainerGameCoordinatorDelegate
  ) {
    self.trainerGameService = trainerGameService
    self.navigationController = navigationController
    self.delegate = delegate
  }
  
  func start() {
    let trainerGameViewController = TrainerGameViewController(delegate: self)
    navigationController.pushViewController(trainerGameViewController, animated: true)
  }
  
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
  
}

extension TrainerGameCoordinator: TrainerGameViewControllerDelegate {
  
  func viewControllerViewWillAppear(_ viewController: TrainerGameViewController) {
    loadPokemonData(for: viewController)
  }
  
  func viewControllerDidCompleteSelection(_ viewController: TrainerGameViewController) {
    loadPokemonData(for: viewController)
  }
  
}
