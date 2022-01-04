extension ApplicationCoordinator: LandingCoordinatorDelegate {
  func landingCoordinatorCompleted(_ coordinator: LandingCoordinator) {
    remove(coordinator: coordinator)
    
//    let coordinator = OnboardingCoordinator(navigationController: navigationController,
//                                            delegate: self)
//    let coordinator = TabBarCoordinator(navigationController: navigationController,
//                                        delegate: self)
//    start(coordinator: coordinator)
  }

}
