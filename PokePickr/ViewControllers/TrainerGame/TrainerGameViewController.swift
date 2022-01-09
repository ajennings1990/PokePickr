import UIKit

protocol TrainerGameViewControllerDelegate: AnyObject {
  
}

class TrainerGameViewController: UIViewController {
  
  // UIComponents
  
  // --> Close Button
  
  // --> Progress Bar / Text Label
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Select a Pokemon"
    label.textAlignment = .center
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 33, weight: .heavy)
    return label
  }()
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.register(
      PokemonCollectionViewCell.self,
      forCellWithReuseIdentifier: PokemonCollectionViewCell.reuseIdentifier
    )
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.allowsSelection = true
    return collectionView
  }()
  
  // Private Members
  
  private let sectionInsets = UIEdgeInsets(
    top: 100.0,
    left: 20.0,
    bottom: 50.0,
    right: 20.0
  )
  
  // private lazy var selections = [Pokemon]() <-- pass individual selections to coordinator or as Array ???
  
  private weak var delegate: TrainerGameViewControllerDelegate?
  
  // Lifecycle
  
  init(delegate: TrainerGameViewControllerDelegate) {
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
    
    [titleLabel, collectionView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
  }
  
  private func makeConstraints() {
    NSLayoutConstraint.activate([
      self.titleLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
      self.titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
      self.titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
      self.titleLabel.heightAnchor.constraint(equalToConstant: 30),
      
      self.collectionView.topAnchor.constraint(equalTo: titleLabel.topAnchor,constant: 20),
      self.collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      self.collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
      self.collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
    ])
  }
  
  // Handle Selections
  
  private func handleSelection(_ indexPath: IndexPath, on collectionView: UICollectionView) {
    let selectedCell = collectionView.cellForItem(at: indexPath)
    
    var otherCell: UICollectionViewCell?
    if indexPath.row == 1 {
      otherCell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0))
    } else {
      otherCell = collectionView.cellForItem(at: IndexPath(item: 1, section: 0))
    }
    
    guard let selectedCell = selectedCell, let otherCell = otherCell  else {
      animationsCompleted()
      return
    }

    animateCells(selectedCell, otherCell)
  }
  
  private func animateCells(_ selectedCell: UICollectionViewCell, _ otherCell: UICollectionViewCell) {
    UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 2.0, options: .curveLinear) {
      selectedCell.transform = selectedCell.transform.scaledBy(x: 1.1, y: 1.1)
      otherCell.transform = otherCell.transform.scaledBy(x: 0.9, y: 0.9)
      otherCell.alpha = 0.7
    } completion: { completed in
      guard completed == true else { return }
      selectedCell.transform = selectedCell.transform.scaledBy(x: 0.9, y: 0.9)
      otherCell.transform = otherCell.transform.scaledBy(x: 1.1, y: 1.1)
      otherCell.alpha = 1.0
      self.animationsCompleted()
    }
  }
  
  private func animationsCompleted() {
    
  }
  
}

extension TrainerGameViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCell(
      withReuseIdentifier: PokemonCollectionViewCell.reuseIdentifier,
      for: indexPath
    )
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  
}

extension TrainerGameViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    handleSelection(indexPath, on: collectionView)
  }
  
  func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
    
  }
  
}

extension TrainerGameViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let itemsPerRow = CGFloat(2)
    
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow
    
    return CGSize(width: widthPerItem, height: 300)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return sectionInsets
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return sectionInsets.left
  }
  
}
