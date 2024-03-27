//
//  Model.swift
//  ClipInterview
//
//  Created by Sergio Andres Rodriguez Castillo on 27/03/24.
//

import Foundation

struct Model: Decodable {
    var data: Children
}

struct Children: Decodable {
    var children: [ChildrenData]
}

struct ChildrenData: Decodable {
    var data: ChildrenDetail
}

struct ChildrenDetail: Decodable {
    var title: String
}
