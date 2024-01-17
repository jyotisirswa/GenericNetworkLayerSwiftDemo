//
//  ViewModelInjectable.swift
//  GenericNetworkLayerApp
//
//  Created by Jyoti - LetsWork on 1/12/24.
//

import Foundation
protocol ViewModelInjectable {
    associatedtype ViewModel
    func configureWithViewModel(_ model : ViewModel)
}

