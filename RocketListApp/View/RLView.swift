//
//  RLView.swift
//  RocketListApp
//
//  Created by nur kholis on 10/02/23.
//

import UIKit

protocol RocketListViewDelegate: AnyObject {
  func rmRocketListView(
    _ rocketListView: RLView,
    didSelectRocket rocket: RocketTableViewModel
  )
}

class RLView: UIView {

  public weak var delegate: RocketListViewDelegate?
  private var viewModel = RocketListViewViewModel()

  let errorView = ErrorView()

  private let inputField: UITextField = {
    let sampleTextField = UITextField(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: ScreenSize.width, height: 40)))
    sampleTextField.placeholder = "Search..."
    sampleTextField.font = UIFont.systemFont(ofSize: 15)
    sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
    sampleTextField.autocorrectionType = UITextAutocorrectionType.no
    sampleTextField.keyboardType = UIKeyboardType.default
    sampleTextField.returnKeyType = UIReturnKeyType.done
    sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
    sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
    return sampleTextField
  }()

  private let tableView: UITableView = {
    let table = UITableView()
    table.register(RLTableViewCell.self, forCellReuseIdentifier: RLTableViewCell.identifier)
    table.separatorStyle = .none
    table.backgroundColor = .clear
    table.showsVerticalScrollIndicator = false
    table.translatesAutoresizingMaskIntoConstraints = false
    return table
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    translatesAutoresizingMaskIntoConstraints = false
    addSubviews(inputField, tableView, errorView)
    addConstraint()
    viewModel.delegate = self
    inputField.delegate = self
    errorView.delegate = self
    viewModel.fetchRocket()
    setTableView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func addConstraint() {
    NSLayoutConstraint.activate([
      inputField.topAnchor.constraint(equalTo: topAnchor),
      inputField.leftAnchor.constraint(equalTo: leftAnchor),
      inputField.rightAnchor.constraint(equalTo: rightAnchor),

      tableView.topAnchor.constraint(equalTo: inputField.bottomAnchor, constant: 20),
      tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
      tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

      errorView.topAnchor.constraint(equalTo: topAnchor),
      errorView.leftAnchor.constraint(equalTo: leftAnchor),
      errorView.rightAnchor.constraint(equalTo: rightAnchor),
      errorView.bottomAnchor.constraint(equalTo: bottomAnchor),

    ])
  }

  func setTableView() {
    tableView.delegate = viewModel
    tableView.dataSource = viewModel
  }
}

extension RLView: RocketListViewModelDelegate {
  func didLoadInitialRockets() {
    DispatchQueue.main.async {
      self.errorView.isHidden = true
      self.tableView.reloadData()
    }
  }

  func didSelectRocket(_ rocket: RocketTableViewModel) {
    delegate?.rmRocketListView(self, didSelectRocket: rocket)
  }

  
}

extension RLView: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return true
  }

  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text!
    let textRange = Range(range, in: currentText)
    let updateText = currentText.replacingCharacters(in: textRange!, with: string)

    if updateText.isNotEmpty {
      let filterArray = viewModel.rockets.filter{ item in
        return item.name.containsIgnoringCase(updateText)
      }
      self.viewModel.cellViewModels.removeAll()
      var cellViewModels: [RocketTableViewModel] = []
      for rocket in filterArray {
        let viewModel = RocketTableViewModel(
          rocketName: rocket.name,
          rocketDescription: rocket.description,
          rocketImage: URL(string: rocket.flickrImages.first ?? ""),
          country: rocket.country,
          costPerLaunch: rocket.costPerLaunch,
          firstFlight: rocket.firstFlight
        )
        cellViewModels.append(viewModel)
      }
      self.viewModel.cellViewModels = cellViewModels
    } else {
      self.viewModel.cellViewModels.removeAll()
      self.viewModel.rockets = self.viewModel.defaultRockets
    }
    tableView.reloadData()
    return true
  }

}

extension RLView: ErrorViewDelegate {
  func buttonClicked() {
    viewModel.fetchRocket()
  }
}
