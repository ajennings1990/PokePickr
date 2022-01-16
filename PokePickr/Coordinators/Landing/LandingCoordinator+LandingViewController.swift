import Foundation

extension LandingCoordinator: LandingViewControllerDelegate {
  
  func landingViewControllerDidComplete(_ landingViewController: LandingViewController) {
    landingViewController.dismiss(animated: true) { [weak self] in
      guard let self = self else { return }
      self.delegate?.landingCoordinatorCompleted(self)
    }
  }
  
}
