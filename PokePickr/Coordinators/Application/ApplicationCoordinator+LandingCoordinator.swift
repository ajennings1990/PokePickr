extension ApplicationCoordinator: LandingCoordinatorDelegate {
  func landingCoordinatorCompleted(_ coordinator: LandingCoordinator) {
    remove(coordinator: coordinator)
    
    let coordinator = MainViewCoordinator(
      navigationController: navigationController,
      delegate: self
    )
    start(coordinator: coordinator)
  }
}

extension ApplicationCoordinator: MainViewCoordinatorDelegate {
  
  func mainViewCoordinatorCompleted(_ coordinator: MainViewCoordinator) {
    
  }
  
}
