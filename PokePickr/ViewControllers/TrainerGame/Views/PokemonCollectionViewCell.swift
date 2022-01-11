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
    }
  }
  
  // MARK: - UIComponents
  
  private lazy var nameLabel: UILabel = makeLabel(text: "")
  private lazy var numberLabel: UILabel = makeLabel(text: "")
  
  private lazy var pokemonImageView: UIImageView = {
    let imageView = UIImageView()// makeImageView(with: #imageLiteral(resourceName: "response"))
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  private lazy var typeImageView: UIImageView = makeImageView(with: #imageLiteral(resourceName: "Grass_Type_Icon"))
  
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
  
  // MARK: - Private Methods
  
  private func initUI() {
    backgroundColor = .white
    layer.cornerRadius = 5.0
    layer.masksToBounds = true
    
    [nameLabel, numberLabel, typeImageView, pokemonImageView].forEach {
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
      
      typeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      typeImageView.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 10),
      typeImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
      typeImageView.heightAnchor.constraint(equalToConstant: 20),
      typeImageView.widthAnchor.constraint(equalToConstant: 20),
      
      pokemonImageView.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 10),
      pokemonImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
      pokemonImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
      pokemonImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
    ])
  }
  
  private func makeImageView(with image: UIImage) -> UIImageView {
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
