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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.status = try container.decode(String.self, forKey: .status)
        self.species = try container.decode(String.self, forKey: .species)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.image = try container.decode(String.self, forKey: .image)
    }
}

struct ModelContainer<Item : Codable> : Codable {
    let results : [Item]
}
