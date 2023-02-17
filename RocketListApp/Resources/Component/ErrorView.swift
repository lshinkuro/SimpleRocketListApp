//
//  ErrorView.swift
//  RocketListApp
//
//  Created by nur kholis on 12/02/23.
//

import UIKit

protocol ErrorViewDelegate {
  func buttonClicked()
}

class ErrorView: UIView {

  let nibName = String(describing: ErrorView.self)
  var delegate: ErrorViewDelegate?



  @UsesAutoLayout
  var labelError: UILabel = {
     let label = UILabel()
    label.textColor = .label
    label.textAlignment = .center
    label.text =  "Terjadi Error"
    label.font = .systemFont(ofSize: 18, weight: .medium)
    return label

  }()

  @UsesAutoLayout
  var errorButton: UIButton = {
    let button = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 50))
    button.backgroundColor = .blue
    button.setTitle("Retry", for: .normal)
    return button
  }()

  @UsesAutoLayout
  var containerView:UIView = {
      let view = UIView()
//      view.clipsToBounds = true
      return view
  }()


  override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
  }

  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
  }



}

extension ErrorView {

  func setup() {
    self.backgroundColor = .white
    translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubviews(labelError)
    addSubviews(containerView, errorButton)
    addConstraint()
    setupButton()
    configure()
  }

  func setupButton() {
    errorButton.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
  }

  @objc func buttonClicked() {
    self.delegate?.buttonClicked()
  }

  func addConstraint() {
    NSLayoutConstraint.activate([

      containerView.centerYAnchor.constraint(equalTo: centerYAnchor ),
      containerView.centerXAnchor.constraint(equalTo: centerXAnchor),


      labelError.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 10),
      labelError.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 10),
      labelError.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -10),

      errorButton.topAnchor.constraint(equalTo: labelError.bottomAnchor, constant: 20),
      errorButton.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 10),
      errorButton.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -10),
      errorButton.widthAnchor.constraint(equalToConstant: 200),
      errorButton.heightAnchor.constraint(equalToConstant: 40)

    ])
  }

  func configure() {
    self.labelError.text = "Terjadi Error"
  }
}
