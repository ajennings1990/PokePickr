import UIKit

protocol MainViewControllerDelegate: AnyObject {
  
}

class MainViewController: UIViewController {
  
  // UI Components
  
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
//    button.configuration = .borderedProminent()
    button.layer.cornerRadius = 5.0
    button.titleLabel?.font = UIFont.systemFont(ofSize: 35, weight: .heavy)
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
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(stackView)
    
    [titleLabel, playButton, settingsButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      stackView.addArrangedSubview($0)
    }
  }
  
  private func makeConstraints() {
    stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    
    stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    playButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
    playButton.widthAnchor.constraint(equalToConstant:  150).isActive = true
  }
  
}
