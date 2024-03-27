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
    func requestListData()
}

class ListViewModel: ListViewModelProtocol {
    var serviceManager: ServiceManagerProtocol
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
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
}
