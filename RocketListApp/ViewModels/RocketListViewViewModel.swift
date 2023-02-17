//
//  RocketListViewViewModel.swift
//  RocketListApp
//
//  Created by nur kholis on 10/02/23.
//

import Foundation
import UIKit

protocol RocketListViewModelDelegate: AnyObject {
  func didLoadInitialRockets()
  func didSelectRocket(_ rocket: RocketTableViewModel)
}

final class RocketListViewViewModel: NSObject {

  public weak var delegate: RocketListViewModelDelegate?

  var isLoadingPage = false
  var cellViewModels: [RocketTableViewModel] = []
  var defaultRockets: [RocketsListModel] = []
  var rockets: [RocketsListModel] = [] {
    didSet {
      for rocket in rockets {
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
    }
  }

  func fetchRocket()  {
    guard !isLoadingPage  else {
        return
    }
    isLoadingPage = true
    RMService.shared.execute(endpoint: .fetchRocket, expecting: [RocketsListModel].self) { result in
      switch result {
      case .success(let model):
        self.isLoadingPage = false
        self.defaultRockets = model
        self.rockets = model
        DispatchQueue.main.async {
          self.delegate?.didLoadInitialRockets()
        }
      case .failure(let error):
        self.isLoadingPage = false
        print(String(describing: error))
      }
    }
  }
}

extension RocketListViewViewModel: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    if isLoadingPage {
      tableView.setLoading()
    } else {
      if cellViewModels.isEmpty {
        tableView.setEmptyMessage(message: "Tidak Ada Data Rocket")
      }else {
        tableView.restore()
      }
    }

    return cellViewModels.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: RLTableViewCell.identifier, for: indexPath) as? RLTableViewCell else {
      fatalError("unsupported cell")
    }
    let viewModel = cellViewModels[indexPath.row]
    cell.configure(viewModel: viewModel)
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 110
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let rocket = cellViewModels[indexPath.row]
    delegate?.didSelectRocket(rocket)
  }
  
}

