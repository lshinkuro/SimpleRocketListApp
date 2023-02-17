//
//  RLTableViewCell.swift
//  RocketListApp
//
//  Created by nur kholis on 10/02/23.
//

import UIKit

class RLTableViewCell: UITableViewCell {

    static let identifier = "RLTableViewCell"

    @UsesAutoLayout
    var imgView: UIImageView = {
      let image = UIImageView()
      image.contentMode = .scaleAspectFill
      image.layer.cornerRadius = 35
      image.clipsToBounds = true
      return image
    }()

    @UsesAutoLayout
    var containerView:UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()

    @UsesAutoLayout
    private var nameLabel: UILabel = {
      let label = UILabel()
      label.textColor = .label
      label.font = .systemFont(ofSize: 17, weight: .medium)
      return label
    }()

    @UsesAutoLayout
    private var statusLabel: UILabel = {
      let label = UILabel()
      label.textColor = .secondaryLabel
      label.font = .systemFont(ofSize: 15, weight: .regular)
      label.numberOfLines = 0
      return label
    }()

    @UsesAutoLayout
    var arrowImage:UIImageView = {
         let img = UIImageView()
         img.contentMode = .scaleAspectFill
         img.layer.cornerRadius = 13
         img.clipsToBounds = true
         return img
     }()

  @UsesAutoLayout
  var viewContent: UIView = {
      let view = UIView()
      view.layer.borderWidth = 1
      view.layer.borderColor = UIColor.gray.cgColor
      view.layer.shadowOpacity = 0.23
      view.layer.shadowRadius = 7
      view.layer.shadowOffset = .zero
      view.layer.shadowColor = UIColor.gray.cgColor
      view.layer.cornerRadius = 10
      view.layer.masksToBounds = true
      return view
  }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setupLayer()
      self.selectionStyle = .none
      containerView.addSubviews(nameLabel,statusLabel)
      viewContent.addSubviews(imgView,containerView,arrowImage)
      self.contentView.addSubviews(viewContent)
      addConstraint()
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

  func setupLayer() {
       backgroundColor = .clear // very important
       contentView.backgroundColor = .white
       contentView.layer.cornerRadius = 8
  }

    override func prepareForReuse() {
      super.prepareForReuse()
      self.imgView.image = nil
      self.nameLabel.text = nil
      self.statusLabel.text = nil
      self.arrowImage.image = nil
    }

    func addConstraint() {

      NSLayoutConstraint.activate([

        viewContent.centerYAnchor.constraint(equalTo: centerYAnchor),
        viewContent.centerXAnchor.constraint(equalTo: centerXAnchor),
        viewContent.topAnchor.constraint(equalTo: topAnchor, constant: 5),
        viewContent.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
        viewContent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        viewContent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),


       imgView.centerYAnchor.constraint(equalTo:self.viewContent.centerYAnchor),
       imgView.leadingAnchor.constraint(equalTo:self.viewContent.leadingAnchor, constant:10),
       imgView.widthAnchor.constraint(equalToConstant:70),
       imgView.heightAnchor.constraint(equalToConstant:70),

       containerView.centerYAnchor.constraint(equalTo:self.viewContent.centerYAnchor),
       containerView.leadingAnchor.constraint(equalTo:self.imgView.trailingAnchor, constant:10),
       containerView.heightAnchor.constraint(equalToConstant:60),
       nameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor),
       nameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor),
       nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor),

       statusLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor),
       statusLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor),
       statusLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor),
       statusLabel.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor),


       arrowImage.leadingAnchor.constraint(equalTo:self.containerView.trailingAnchor, constant:10),
       arrowImage.widthAnchor.constraint(equalToConstant:26),
       arrowImage.heightAnchor.constraint(equalToConstant:26),
       arrowImage.trailingAnchor.constraint(equalTo:self.viewContent.trailingAnchor, constant:-20),
       arrowImage.centerYAnchor.constraint(equalTo:self.viewContent.centerYAnchor),

      ])
    }

  func configure(viewModel: RocketTableViewModel) {
    nameLabel.text =  viewModel.rocketName
    statusLabel.text =  viewModel.rocketDescription
    arrowImage.image = SFSymbols.arrowSymbol

    viewModel.fetchImage { [weak self] result in
      switch result {
      case .success(let data):
        DispatchQueue.main.async {
          let image = UIImage(data: data)
          self?.imgView.image = image
        }
      case .failure(let error):
        print(String(describing: error))
        break
      }
    }
  }

}
