//
//  MusicViewModel.swift
//  GenericNetworkLayerApp
//
//  Created by Jyoti - LetsWork on 1/12/24.
//

import Foundation
import Combine
import UIKit

@MainActor
final class MusicViewModel : ObservableObject {
    private let client = HttpClient()
    @Published private(set) var model : [Model] = []
    @Published private(set) var errorMessage: String = ""
    
    var request : URLRequest = {
        let urlString =  "\(BASE_URL)/character"
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }()
    
    func fetchRequest() async {
        do {
            let container = try await client.fetchDataFromServer(type: ModelContainer<Model>.self , with: APIs.characters.request) //request
            model = container.results.map{$0}
            print("---Calling api---")
            print(model)
        } catch {
            errorMessage = error.localizedDescription
        }
        print("---Calling api 1--")
    }
}
