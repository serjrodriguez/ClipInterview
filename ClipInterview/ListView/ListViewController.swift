//
//  ViewController.swift
//  ClipInterview
//
//  Created by Sergio Andres Rodriguez Castillo on 27/03/24.
//

import UIKit

class ListViewController: BaseViewController {
    
    var viewModel: ListViewModelProtocol
    
    init(viewModel: ListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    lazy var tableView: UITableView! = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "List View"
        configureTableView()
        bindViewModel()
        requestData()
    }
    
    private func bindViewModel() {
        viewModel.reloadView = { [weak self] in
            self?.reloadView()
        }
        viewModel.manageError = { [weak self] error in
            self?.showErrorAlert(error.localizedDescription)
        }
    }
    
    private func reloadView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func requestData() {
        viewModel.requestListData()
    }
    
    private func showErrorAlert(_ titleString: String) {
        presentAlertWithTitle(titleString, firstActionTitle: "OK", secondActionTitle: "Retry", secondActionStyle: .default) { [weak self] _ in
            self?.requestData()
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = viewModel.getDataAtRow(indexPath.row) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = model.data.title
        return cell
    }
}
