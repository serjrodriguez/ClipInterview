//
//  Helpers.swift
//  ClipInterviewTests
//
//  Created by Sergio Andres Rodriguez Castillo on 27/03/24.
//

@testable import ClipInterview
import Foundation

func makeMockData() -> Model {
    return Model(data: Children(children: [ChildrenData(data: ChildrenDetail(title: "Test Title"))]))
}
