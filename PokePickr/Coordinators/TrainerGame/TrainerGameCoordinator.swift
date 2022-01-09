import UIKit

protocol TrainerGameCoordinatorDelegate: AnyObject {
  func trainerGameCoordinatorCompleted(_ coordinator: MainViewCoordinator)
}

class TrainerGameCoordinator: CoordinatorAutoCleanable {
  
  // MARK: - Public Members
  
  var children: [String: Coordinator] = [:]
  weak var delegate: TrainerGameCoordinatorDelegate?
  let navigationController: UINavigationController

  // MARK: - Lifecycle

  init(
    navigationController: UINavigationController,
    delegate: TrainerGameCoordinatorDelegate
  ) {
    self.delegate = delegate
    self.navigationController = navigationController
  }
  
  func start() {
    let trainerGameViewController = TrainerGameViewController(delegate: self)
    navigationController.pushViewController(trainerGameViewController, animated: true)
  }
  
}

extension TrainerGameCoordinator: TrainerGameViewControllerDelegate {
  
  
  
}
