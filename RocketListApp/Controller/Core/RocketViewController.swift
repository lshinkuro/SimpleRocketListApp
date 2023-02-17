//
//  ViewController.swift
//  RocketListApp
//
//  Created by nur kholis on 10/02/23.
//

import UIKit

class RocketViewController: UIViewController {


  private let rocketListView = RLView()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupView()
  }

  func setupView() {
    view.addSubview(rocketListView)
    rocketListView.delegate = self
    title = "Rocket List"
    NSLayoutConstraint.activate([
      rocketListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      rocketListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      rocketListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      rocketListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }

}

extension RocketViewController: RocketListViewDelegate {

  func rmRocketListView(_ rocketListView: RLView, didSelectRocket rocket: RocketTableViewModel) {
    let viewModel = RocketListDetailViewModel(rocket: rocket)
    let vc = RocketListDetailViewController(viewModel: viewModel)
    vc.hidesBottomBarWhenPushed = true
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

