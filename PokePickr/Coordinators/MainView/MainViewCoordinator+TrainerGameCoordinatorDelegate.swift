extension MainViewCoordinator: TrainerGameCoordinatorDelegate {
  
  func trainerGameCoordinatorCompleted(_ coordinator: TrainerGameCoordinator) {
    remove(coordinator: coordinator)
    navigationController.popToRootViewController(animated: true)
  }
  
}
