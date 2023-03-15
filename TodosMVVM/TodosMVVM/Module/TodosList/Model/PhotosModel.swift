//
//  PhotosModel.swift
//  TodosMVVM
//
//  Created by Adlan Nourindiaz on 15/03/23.
//

import Foundation


struct PhotosModel: Codable {
    
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    
 
    enum CodingKeys: String, CodingKey {
        case albumId = "albumId"
        case id = "id"
        case title = "title"
        case url = "url"
    }
    
}
