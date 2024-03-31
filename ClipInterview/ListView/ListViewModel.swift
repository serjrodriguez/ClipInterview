//
//  ListViewModel.swift
//  ClipInterview
//
//  Created by Sergio Andres Rodriguez Castillo on 27/03/24.
//

import Foundation

enum URLStrings: String {
    case dataListString = "https://ssl.reddit.com/r/popular/top.json"
}

protocol ListViewModelProtocol {
    var reloadView: (() -> Void)? { get set }
    var manageError: ((Error) -> Void)? { get set }
    func requestListData()
    func getNumberOfRows() -> Int
    func getDataAtRow(_ row: Int) -> ChildrenData?
}

class ListViewModel: ListViewModelProtocol {
    var serviceManager: ServiceManagerProtocol
    var reloadView: (() -> Void)?
    var manageError: ((Error) -> Void)?
    var model: Model?
    
    init(serviceManager: ServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
    
    func requestListData() {
        serviceManager.requestDataFromURL(URLStrings.dataListString.rawValue) { [weak self] (result: Result<Model, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.model = response
                self.reloadView?()
            case .failure(let error):
                self.manageError?(error)
            }
        }
    }
    
    func getNumberOfRows() -> Int {
        return model?.data.children.count ?? 0
    }
    
    func getDataAtRow(_ row: Int) -> ChildrenData? {
        return model?.data.children[safe: row]
    }
}

private extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
