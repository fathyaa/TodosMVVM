//
//  Model.swift
//  BikinMVVM
//
//  Created by Phincon on 13/03/23.
//

import Foundation

struct Todos: Codable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool

    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case completed
    }
}
