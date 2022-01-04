import UIKit



class LandingViewController: UIViewController {
    
    // MARK: - Lifecycle

    public init() {
      super.init(nibName: nil, bundle: nil)
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
    }

    // MARK - Setup

    private func loadUI() {
      view.backgroundColor = UIColor.mainBlue
    }
    
}
