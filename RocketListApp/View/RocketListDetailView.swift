//
//  RocketListDetailView.swift
//  RocketListApp
//
//  Created by nur kholis on 10/02/23.
//

import UIKit

class RocketListDetailView: UIView {

  //UI Variables
  @UsesAutoLayout
  var rocketImageView: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.clipsToBounds = true
    return image
  }()

  @UsesAutoLayout
  var nameLabel: UILabel = {
     let label = UILabel()
    label.textColor = .label
    label.font = .systemFont(ofSize: 17, weight: .medium)    
    return label

  }()
  
  @UsesAutoLayout
  var descriptionLabel: UILabel = {
    let label = UILabel()
    label.textColor = .secondaryLabel
    label.font = .systemFont(ofSize: 15, weight: .regular)
    label.numberOfLines = 0
    return label
  }()


  @UsesAutoLayout
  var costPerLaunch: UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.font = .systemFont(ofSize: 15, weight: .regular)
    label.numberOfLines = 0
    return label
  }()

  @UsesAutoLayout
  var country: UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.font = .systemFont(ofSize: 15, weight: .regular)
    label.numberOfLines = 0
    return label
  }()

  @UsesAutoLayout
  var firstFlight: UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.font = .systemFont(ofSize: 15, weight: .regular)
    label.numberOfLines = 0
    return label
  }()

  @UsesAutoLayout
  private var labelsStackView = UIStackView()



  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    translatesAutoresizingMaskIntoConstraints = false
    configureLabels()
    self.addSubviews(rocketImageView, labelsStackView)
    configureViewLayout()
  }

  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  func configureLabels() {
    labelsStackView.axis = .vertical
    labelsStackView.alignment = .leading
    labelsStackView.spacing   = 4.0

    labelsStackView.addArrangedSubview(nameLabel)
    labelsStackView.addArrangedSubview(descriptionLabel)
    labelsStackView.addArrangedSubview(costPerLaunch)
    labelsStackView.addArrangedSubview(country)
    labelsStackView.addArrangedSubview(firstFlight)

  }

  private func configureViewLayout() {
      backgroundColor = .systemBackground
      NSLayoutConstraint.activate([
          rocketImageView.topAnchor.constraint(equalTo: topAnchor),
          rocketImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
          rocketImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
          rocketImageView.widthAnchor.constraint(equalToConstant:ScreenSize.width),
          rocketImageView.heightAnchor.constraint(equalToConstant:400),

          labelsStackView.topAnchor.constraint(equalTo: rocketImageView.bottomAnchor, constant: 15.0),
          labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
          labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
      ])
  }



  func configure(viewModel: RocketListDetailViewModel) {
    nameLabel.text = "Name: \(viewModel.rocket.rocketName)"
    descriptionLabel.text = "Description: \(viewModel.rocket.rocketDescription)"
    country.text = "Country: \(viewModel.rocket.country)"
    firstFlight.text = "First Flight: \(viewModel.rocket.firstFlight)"
    costPerLaunch.text = "Cost Perlaunch: \(viewModel.rocket.costPerLaunch.convertToCurrency())"

    viewModel.fetchImage { [weak self] result in
      switch result {
      case .success(let data):
        DispatchQueue.main.async {
          let image = UIImage(data: data)
          self?.rocketImageView.image = image
          self?.rocketImageView.layoutIfNeeded()

        }
      case .failure(let error):
        print(String(describing: error))
        break
      }
      
    }
  }
}
