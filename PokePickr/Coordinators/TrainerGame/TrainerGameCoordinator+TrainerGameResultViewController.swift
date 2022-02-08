extension TrainerGameCoordinator: TrainerGameResultViewControllerDelegate {
  
  func viewControllerDidPressDone(_ viewController: TrainerGameResultViewController) {
    navigationController.dismiss(animated: true, completion: { [weak self] in
      guard let self = self else { return }
      self.delegate?.trainerGameCoordinatorCompleted(self)
    })
  }
  
}
