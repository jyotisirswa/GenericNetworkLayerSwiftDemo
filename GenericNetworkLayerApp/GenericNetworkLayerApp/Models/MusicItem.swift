//
//  MusicItem.swift
//  GenericNetworkLayerApp
//
//  Created by Jyoti - LetsWork on 1/12/24.
//

import Foundation
import UIKit

struct Model : Codable {
    let id : Int
    let name : String
    let status : String
    let species : String
    let gender : String
    let image : String
    
    private enum CodingKeys : String, CodingKey {
        case id = "id"
        case name = "name"
        case status = "status"
        case species = "species"
        case gender = "gender"
        case image = "image"
    }
}

struct ModelContainer<Item : Codable> : Codable {
    let results : [Item]
}
