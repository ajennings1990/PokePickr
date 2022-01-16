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
