import UIKit



protocol LandingViewControllerDelegate: AnyObject {
    func landingViewControllerDidComplete(_ landingViewController: LandingViewController)
}

class LandingViewController: UIViewController {
    
    // MARK: - Private Members
    
    private weak var delegate: LandingViewControllerDelegate?
    
    // MARK: - Lifecycle

    public init(delegate: LandingViewControllerDelegate) {
      super.init(nibName: nil, bundle: nil)
      self.delegate = delegate
    }

    required public init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      loadUI()
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      self.delegate?.landingViewControllerDidComplete(self)
    }

    // MARK - Setup

    private func loadUI() {
      view.backgroundColor = UIColor.mainBlue
    }
    
}
