import UIKit

class ApplicationCoordinator: Coordinator {
  
  // MARK: - Required Members
  
  var children: [String : Coordinator] = [:]
  
  // MARK: - Internal Members
  
  var window: UIWindow?
  let navigationController = UINavigationController()
  lazy var landingCoordinator = LandingCoordinator(navigationController: navigationController, delegate: self)
  
  // MARK: - Lifecycle
  
  init(window: UIWindow?) {
    self.window = window
  }
  
  func start() {
    navigationController.isNavigationBarHidden = true
    start(coordinator: landingCoordinator)

    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
  
}

