//
//  PokemonCollectionViewCell.swift
//  PokePickr
//
//  Created by Andrew Jennings on 09/01/2022.
//

import Foundation
import UIKit
import CloudKit

class PokemonCollectionViewCell: UICollectionViewCell {
  
  // Public Members
  
  public static let reuseIdentifier = "PokemonCell"
  
  public var pokemonInfo: PokemonGameInfo? {
    didSet {
      nameLabel.text = pokemonInfo?.name
      numberLabel.text = "#" + (pokemonInfo?.number ?? "000")
      pokemonImageView.image = pokemonInfo?.pokemonImage
      configureTypeImageViews()
    }
  }
  
  // MARK: - UIComponents
  
  private lazy var nameLabel: UILabel = makeLabel(text: "")
  private lazy var numberLabel: UILabel = makeLabel(text: "")
  
  private lazy var typesStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fillEqually
    stackView.axis = .horizontal
    stackView.spacing = 5
    return stackView
  }()
  
  private lazy var pokemonImageView: UIImageView = makeImageView(with: nil)
  private lazy var typeImageView: UIImageView = makeImageView(with: nil)
  
  // MARK: - Private Members
  
  
  
  // MARK: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initUI()
    makeConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    typesStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
  }
  
  // MARK: - Private Methods
  
  private func initUI() {
    backgroundColor = .white
    layer.cornerRadius = 5.0
    layer.masksToBounds = true
    
    [nameLabel, numberLabel, typesStackView, pokemonImageView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
  }
  
  private func makeConstraints() {
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
      nameLabel.heightAnchor.constraint(equalToConstant: 20),
      
      numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
      numberLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
      numberLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
      numberLabel.heightAnchor.constraint(equalToConstant: 20),
      
      typesStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      typesStackView.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 10),
      typesStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
      typesStackView.heightAnchor.constraint(equalToConstant: 20),
      typesStackView.widthAnchor.constraint(lessThanOrEqualToConstant: 40),
      
      pokemonImageView.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 10),
      pokemonImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
      pokemonImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
      pokemonImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
    ])
  }
  
  // MARK: - Pokemon Type Setup
  
  
  private func configureTypeImageViews() {
    pokemonInfo?.types?.forEach { type in
      let imageView = makeImageView(with: type.getImage())
      typesStackView.addArrangedSubview(imageView)
    }
  }
  
  
  // MARK: - Constructors
  
  private func makeImageView(with image: UIImage?) -> UIImageView {
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }
  
  private func makeLabel(text: String) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = text
    label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    label.textColor = .darkGray
    return label
  }
  
  
}
