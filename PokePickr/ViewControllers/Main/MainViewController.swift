import UIKit

protocol MainViewControllerDelegate: AnyObject {
  func playButtonWasPressed(_ viewController: MainViewController)
}

class MainViewController: UIViewController {
  
  // UI Components
    
  private lazy var appLabel: UILabel = {
    let label = UILabel()
    label.text = "PokePickr"
    label.textAlignment = .center
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
    return label
  }()
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fill//Proportionally
    stackView.alignment = .center
    stackView.spacing = 30
    stackView.backgroundColor = UIColor.mainBlue
    return stackView
  }()
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = "What specialist Pókemon type trainer should you be?"
    label.numberOfLines = 2
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .center
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    return label
  }()
  
  private lazy var playButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("Play", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.setTitleColor(.lightGray, for: .selected)
    button.setTitleColor(.lightGray, for: .highlighted)
    button.layer.borderColor = UIColor.white.cgColor
    button.layer.borderWidth = 1.0
    button.clipsToBounds = false
    button.layer.cornerRadius = 5.0
    button.titleLabel?.font = UIFont.systemFont(ofSize: 35, weight: .heavy)
    button.addTarget(self, action: #selector(playButtonWasPressed), for: .touchUpInside)
    return button
  }()
  
  private let settingsButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(.add, for: .normal)
    return button
  }()
  
  // Private Members
  
  private weak var delegate: MainViewControllerDelegate?
  
  // Lifecycle
  
  init(delegate: MainViewControllerDelegate) {
    super.init(nibName: nil, bundle: nil)
    self.delegate = delegate
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initUI()
    makeConstraints()
  }
  
  // Private Methods
  
  private func initUI() {
    view.backgroundColor = UIColor.mainBlue
    
    appLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(appLabel)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(stackView)
    
    [titleLabel, playButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      stackView.addArrangedSubview($0)
    }
  }
  
  private func makeConstraints() {
    
    NSLayoutConstraint.activate([
      appLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
      appLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
      appLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
      
      stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
      stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      playButton.heightAnchor.constraint(equalToConstant: 65),
      playButton.widthAnchor.constraint(equalToConstant:  150)
    ])
  }
  
  // MARK: - UI Actions
  
  @objc private func playButtonWasPressed() {
    delegate?.playButtonWasPressed(self)
  }
  
}
