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
    func requestListData()
    func getNumberOfRows() -> Int
    func getDataAtRow(_ row: Int) -> ChildrenData?
}

class ListViewModel: ListViewModelProtocol {
    var serviceManager: ServiceManagerProtocol
    var reloadView: (() -> Void)?
    var model: Model?
    
    init(serviceManager: ServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
    
    func requestListData() {
        serviceManager.requestDataFromURL(URLStrings.dataListString.rawValue) { (result: Result<Model, Error>) in
            switch result {
            case .success(let response):
                print("Response from service \(response)")
                self.model = response
                self.reloadView?()
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    func getNumberOfRows() -> Int {
        return model?.data.children.count ?? 0
    }
    
    func getDataAtRow(_ row: Int) -> ChildrenData? {
        return model?.data.children[row] ?? nil
    }
}
