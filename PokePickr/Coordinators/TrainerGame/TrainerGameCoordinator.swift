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
  
  private func loadPokemonData(_ completion: @escaping (PokemonGameInfo?) -> Void) {
    trainerGameService.getRandomPokemon { result in
      completion(try? result.get())
    }
  }
  
}

extension TrainerGameCoordinator: TrainerGameViewControllerDelegate {
  
  func viewControllerViewWillAppear(_ viewController: TrainerGameViewController) {
    loadPokemonData { info in
      guard let info = info else { return }
      DispatchQueue.main.async {
        viewController.pokemonInfo.append(info)
      }
    }
    
    loadPokemonData { info in
      guard let info = info else { return }
      DispatchQueue.main.async {
        viewController.pokemonInfo.append(info)
      }
    }
  }
  
}
