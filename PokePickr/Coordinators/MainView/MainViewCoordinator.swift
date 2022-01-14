import UIKit

protocol MainViewCoordinatorDelegate: AnyObject {
  func mainViewCoordinatorCompleted(_ coordinator: MainViewCoordinator)
}

class MainViewCoordinator: CoordinatorAutoCleanable {
  
  // MARK: - Public Members
  
  var children: [String: Coordinator] = [:]
  weak var delegate: MainViewCoordinatorDelegate?
  let navigationController: UINavigationController

  // MARK: - Lifecycle

  init(
    navigationController: UINavigationController,
    delegate: MainViewCoordinatorDelegate
  ) {
    self.delegate = delegate
    self.navigationController = navigationController
  }
  
  func start() {
    let mainViewController = MainViewController(delegate: self)
    navigationController.setViewControllers([mainViewController], animated: false)
  }
  
}

extension MainViewCoordinator: MainViewControllerDelegate {
  
  func playButtonWasPressed(_ viewController: MainViewController) {
    let repository = DefaultPokemonInfoRepository()
    let service = DefaultTrainerGameService(pokemonInfoRepository: repository)

    let coordinator = TrainerGameCoordinator(
      selectionTotal: 10,
      trainerGameService: service,
      navigationController: navigationController,
      delegate: self
    )
    start(coordinator: coordinator)
  }
  
}

extension MainViewCoordinator: TrainerGameCoordinatorDelegate {
  
  func trainerGameCoordinatorCompleted(_ coordinator: MainViewCoordinator) {
    
  }
  
}
