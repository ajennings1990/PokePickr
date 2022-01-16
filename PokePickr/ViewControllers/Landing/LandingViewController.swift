import UIKit

protocol LandingViewControllerDelegate: AnyObject {
  func landingViewControllerDidComplete(_ landingViewController: LandingViewController)
}

class LandingViewController: UIViewController {
  
  // MARK: - UI Components
  
  private lazy var appLabel: UILabel = {
    let label = UILabel()
    label.text = "PokePickr"
    label.textAlignment = .center
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 33, weight: .heavy)
    return label
  }()
  
  // MARK: - Private Members
  
  private var verticalConstraint: NSLayoutConstraint?
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
    initUI()
    makeConstraints()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    beginAnimations()
  }
  
  // MARK - Setup
  
  private func initUI() {
    view.backgroundColor = UIColor.mainBlue
    
    appLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(appLabel)
  }
  
  private func makeConstraints() {
    NSLayoutConstraint.activate([
      appLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      appLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
    ])
    verticalConstraint = appLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    verticalConstraint?.isActive = true
  }
  
  private func beginAnimations() {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
      self.animateLabel()
    }
  }
  
  private func animateLabel() {
    if let verticalConstraint = verticalConstraint {
      NSLayoutConstraint.deactivate([verticalConstraint])
    }
    appLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
    
    UIView.animate(withDuration: 0.8) {
      self.appLabel.transform = self.appLabel.transform.scaledBy(x: 0.6, y: 0.6)
      self.view.layoutIfNeeded()
    } completion: { completed in
      guard completed == true else { return }
      self.handleAnimationsCompleted()
    }
  }
  
  private func handleAnimationsCompleted() {
    delegate?.landingViewControllerDidComplete(self)
  }
  
}
