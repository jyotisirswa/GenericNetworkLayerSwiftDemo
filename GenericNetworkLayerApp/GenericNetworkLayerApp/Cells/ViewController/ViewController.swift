//
//  ViewController.swift
//  GenericNetworkLayerApp
//
//  Created by Jyoti - LetsWork on 1/11/24.
//

import UIKit
import Combine


class ViewController: UIViewController {
    
    //MARK: - Remote
    var viewModel: MusicViewModel = {
        let viewModel = MusicViewModel()
        return viewModel
    }()
    private lazy var cancellables: Set<AnyCancellable> = []
    private var model : [Model] = []

    //MARK: - UI
    private lazy var tableViewList : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = "listTableView"
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    private func bindViewModel() {
        viewModel.$model.sink {[weak self] list in
            self?.model = list
            self?.tableViewList.reloadData()
        }.store(in: &cancellables)
        self.tableViewList.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewList.register(ModelLisCell.self, forCellReuseIdentifier: ModelLisCell.reuseID)
        tableViewList.dataSource = self
        tableViewList.delegate = self
        tableViewList.rowHeight = UITableView.automaticDimension
        tableViewList.estimatedRowHeight = 250
        tableViewList.addSubview(refreshControl)
        view.addSubview(tableViewList)
        NSLayoutConstraint.activate([
            tableViewList.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableViewList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableViewList.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableViewList.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
        performFetch()
        bindViewModel()
    }
    
    private func performFetch()  {
        Task {
            await self.viewModel.fetchRequest()
        }
//        viewModel.$model.sink { (error) in
//            // handle error
//            // 3
//        } receiveValue: {[weak self] (list) in
//            self?.model = list
//            self?.refreshControl.endRefreshing()
//            self?.tableViewList.reloadData()
//        }
//        // 4
//        .store(in: &cancellables)
//        viewModel.$model.sink { [weak self] (list) in
//            self?.model = list
//            self?.refreshControl.endRefreshing()
//            self?.tableViewList.reloadData()
//        }.store(in: &cancellables)
    }
    
    @objc private func refresh() {
        performFetch()
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ModelLisCell.reuseID) as! ModelLisCell
        cell.selectionStyle = .none
        cell.configureWithViewModel(self.model[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
