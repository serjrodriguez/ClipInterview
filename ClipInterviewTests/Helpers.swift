//
//  Helpers.swift
//  ClipInterviewTests
//
//  Created by Sergio Andres Rodriguez Castillo on 27/03/24.
//

@testable import ClipInterview
import Foundation
import UIKit

func makeMockData(_ numberOfChildMembers: Int = 1) -> Model {
    var childrenDataArray: [ChildrenData] = []
    
    for index in 1...numberOfChildMembers {
        childrenDataArray.append(ChildrenData(data: ChildrenDetail(title: "Test title \(index)")))
    }
    
    return Model(data: Children(children: childrenDataArray))
}

func putInViewHierarchy(_ viewController: UIViewController) {
    let window = UIWindow()
    window.addSubview(viewController.view)
}

func executeRunLoop() {
    RunLoop.current.run(until: Date())
}
