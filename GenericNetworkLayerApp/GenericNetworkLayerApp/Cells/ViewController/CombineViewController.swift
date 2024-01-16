//
//  CombineViewController.swift
//  GenericNetworkLayerApp
//
//  Created by Jyoti - LetsWork on 1/15/24.
//
import UIKit
import Combine

class CombineViewController: UIViewController {
    //MARK: - Remote
    private lazy var viewModel: CombineViewModel = {
        let viewModel = CombineViewModel()
        return viewModel
    }()
    private var cancellables: Set<AnyCancellable> = []

    //MARK: - UI
    private lazy var tableViewList : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.accessibilityIdentifier = "listTableView"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var activityIndicator : UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
    }
    private func setupTableView() {
        navigationItem.title = "List"
        self.view.backgroundColor = .gray
        tableViewList.register(ModelLisCell.self, forCellReuseIdentifier: ModelLisCell.reuseID)
        tableViewList.dataSource = self
        tableViewList.rowHeight = UITableView.automaticDimension
        tableViewList.estimatedRowHeight = 250
        view.addSubviews(tableViewList, activityIndicator)
        let margins = view.layoutMarginsGuide
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableViewList.topAnchor.constraint(equalTo: guide.topAnchor),
            tableViewList.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            tableViewList.rightAnchor.constraint(equalTo: margins.rightAnchor),
            tableViewList.leftAnchor.constraint(equalTo: margins.leftAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        print("--calling apis vc--")
        self.activityIndicator.startAnimating()
        Task {
            await self.viewModel.fetchRequestFromJSON()
        }
        //self.viewModel.fetchRequest()
        print("--calling apis vc 1--")
        print(navigationItem.title ?? "")
    }
    
    private func bindViewModel() {
//        viewModel.$employees.sink { (error) in
//            // handle error
//            // 3
//        } receiveValue: {[weak self] _ in
//            self?.showTableView()
//        }.store(in: &cancellables)
//        
        viewModel.$employees.sink { [weak self] _ in
            print("--calling apis vc 2--")
            self?.showTableView()
        }.store(in: &cancellables)
        print("--calling apis vc 3--")
    }
    
    private func showTableView() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableViewList.reloadData()
        }
    }
}
extension CombineViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ModelLisCell.reuseID) as! ModelLisCell
        cell.selectionStyle = .none
        cell.configureWithViewModel(self.viewModel.employees[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

