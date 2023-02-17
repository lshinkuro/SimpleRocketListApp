//
//  RocketListDetailViewController.swift
//  RocketListApp
//
//  Created by nur kholis on 10/02/23.
//

import UIKit

class RocketListDetailViewController: UIViewController {

  private let rocketListDetailView = RocketListDetailView()
  private let viewModel: RocketListDetailViewModel

  override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }

  override func viewWillAppear(_ animated: Bool) {
    rocketListDetailView.configure(viewModel: viewModel)
  }


  init(viewModel: RocketListDetailViewModel ){
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError(" unsupported uiView")
  }

  func setupView() {
    title = viewModel.title
    view.backgroundColor = .white
    view.addSubview(rocketListDetailView)
    NSLayoutConstraint.activate([
      rocketListDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      rocketListDetailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      rocketListDetailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      rocketListDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])



  }




}
