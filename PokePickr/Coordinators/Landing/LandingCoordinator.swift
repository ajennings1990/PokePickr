import UIKit

protocol LandingCoordinatorDelegate: AnyObject {
  func landingCoordinatorCompleted(_ coordinator: LandingCoordinator)
}

class LandingCoordinator: CoordinatorAutoCleanable {
  
  // MARK: - Public Members
  
  var children: [String: Coordinator] = [:]
  weak var delegate: LandingCoordinatorDelegate?
  let navigationController: UINavigationController

  // MARK: - Lifecycle

  init(
    navigationController: UINavigationController,
    delegate: LandingCoordinatorDelegate
  ) {
    self.delegate = delegate
    self.navigationController = navigationController
  }
  
  func start() {
    let landingViewController = LandingViewController(delegate: self)
    navigationController.setViewControllers([landingViewController], animated: false)
  }
  
}
