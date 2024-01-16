//
//  ObservableViewController.swift
//  GenericNetworkLayerApp
//
//  Created by Jyoti - LetsWork on 1/15/24.
//

import UIKit

class ObservableViewController: UIViewController {
    
    //MARK: - UI
    private lazy var tableViewList : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var activityIndicator : UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    private lazy var viewModel: ObservableViewModel = {
        let viewModel = ObservableViewModel()
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
        setupTableView()
    }
    
    private func setupTableView() {
        tableViewList.register(ModelLisCell.self, forCellReuseIdentifier: ModelLisCell.reuseID)
        tableViewList.dataSource = self
        tableViewList.rowHeight = UITableView.automaticDimension
        tableViewList.estimatedRowHeight = 250
        view.addSubviews(tableViewList, activityIndicator)
        NSLayoutConstraint.activate([
            tableViewList.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableViewList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableViewList.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableViewList.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        self.viewModel.employees.bind {[weak self] (_) in
            self?.showTableView()
        }
        Task {
           await self.viewModel.fetchRequest()
        }
    }
    
    private func showTableView() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            if self.viewModel.employees.value.isEmpty {
                print(self.viewModel.errorMessage.value ?? "")
            } else {
                self.tableViewList.reloadData()
            }
        }
    }
}

extension ObservableViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.employees.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ModelLisCell.reuseID) as! ModelLisCell
        cell.selectionStyle = .none
        cell.configureWithViewModel(self.viewModel.employees.value[indexPath.item])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
