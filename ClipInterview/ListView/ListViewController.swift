//
//  ViewController.swift
//  ClipInterview
//
//  Created by Sergio Andres Rodriguez Castillo on 27/03/24.
//

import UIKit

class ListViewController: UIViewController {
    
    var viewModel: ListViewModelProtocol
    
    init(viewModel: ListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func presentAlertWithTitle(
        _ title: String?,
        message msg: String? = nil,
        firstActionTitle: String? = nil,
        firstAction firstActionHandler: @escaping ((UIAlertAction) -> Void) = { _ in },
        firstActionStyle firstStyle: UIAlertAction.Style = .default,
        secondActionTitle: String? = nil,
        secondActionStyle secondStyle: UIAlertAction.Style = .cancel,
        secondAction secondActionHandler: @escaping ((UIAlertAction) -> Void) = { _ in }
    ) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        if let firstActionTitle = firstActionTitle {
            let firstAction = UIAlertAction(title: firstActionTitle,
                                            style: firstStyle,
                                            handler: firstActionHandler)
            alertController.addAction(firstAction)
            alertController.preferredAction = firstAction
        }
        if let secondActionTitle = secondActionTitle {
            let secondAction = UIAlertAction(title: secondActionTitle,
                                             style: secondStyle,
                                             handler: secondActionHandler)
            alertController.addAction(secondAction)
        }
        
        self.present(alertController, animated: true)
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
