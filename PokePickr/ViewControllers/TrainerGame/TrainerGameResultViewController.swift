import UIKit

protocol TrainerGameResultViewControllerDelegate: AnyObject {
  func viewControllerDidPressDone(_ viewController: TrainerGameViewController)
}

class TrainerGameResultViewController: UIViewController {
  
  private lazy var pokemonStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fillEqually
    stackView.axis = .horizontal
    stackView.spacing = 10
    return stackView
  }()
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.text = "Your Result is"
    label.textColor = .darkGray
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
    return label
  }()
    
  private lazy var typeLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.text = "\(resultType.rawValue)"
    label.textColor = .black
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 50, weight: .heavy)
    return label
  }()
  
  private lazy var typeImageView: UIImageView = makeImageView(with: resultType.getImage())
  
  // MARK: - Private Members
  
  private weak var delegate: TrainerGameResultViewControllerDelegate?
  private let resultType: PokemonType
  private let selections: [PokemonGameInfo]
  
  // MARK: - Lifecycle
  
  public init(
    delegate: TrainerGameResultViewControllerDelegate,
    resultType: PokemonType,
    selections: [PokemonGameInfo]
  ) {
    self.delegate = delegate
    self.resultType = resultType
    self.selections = selections
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initUI()
    makeConstraints()
  }
  
  // MARK: - Private Methods
  
  private func initUI() {
    view.backgroundColor = .white
    
    selections
      .filter { $0.types?.contains(resultType) == true }
      .forEach {
        let imageView = makeImageView(with: $0.pokemonImage)
        pokemonStackView.addArrangedSubview(imageView)
      }
    
    
    [titleLabel, typeLabel, typeImageView, pokemonStackView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
  }
  
  private func makeConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
      titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
      titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),

      typeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
      typeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
      typeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),

      typeImageView.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 20),
      typeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      typeImageView.heightAnchor.constraint(equalToConstant: 60),
      typeImageView.widthAnchor.constraint(equalToConstant: 60),
      
      pokemonStackView.topAnchor.constraint(equalTo: typeImageView.bottomAnchor, constant: 40),
      pokemonStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
      pokemonStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
      pokemonStackView.heightAnchor.constraint(equalToConstant: 150)
    ])
    
  }
  
  // MARK: - Constructors
  
  private func makeImageView(with image: UIImage?) -> UIImageView {
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }
  
}
