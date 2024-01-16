//
//  IdentifiableHashable.swift
//  GenericNetworkLayerApp
//
//  Created by Jyoti - LetsWork on 1/12/24.
//

import Foundation

protocol IdentifiableHashable: Hashable & Identifiable {}
extension IdentifiableHashable {
    static func == (lhs: Self, rhs: Self) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
