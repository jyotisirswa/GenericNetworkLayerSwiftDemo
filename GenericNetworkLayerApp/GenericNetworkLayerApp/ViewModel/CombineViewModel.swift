//
//  CombineViewModel.swift
//  GenericNetworkLayerApp
//
//  Created by Jyoti - LetsWork on 1/15/24.
//

import Foundation

class CombineViewModel: ObservableObject {
    private let client = HttpClient()
    private(set) var errorMessage: String?
    @Published private(set)  var employees: [Model] = []
    
    private var request : URLRequest = {
        let urlString =  "\(BASE_URL)/character"
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }()

    func fetchRequest() {
        Task.init {
            do {
                let container = try await client.fetchDataFromServer(type: ModelContainer<Model>.self , with: APIs.characters.request) //request
                self.employees = container.results.map{$0}
            } catch {
                self.setError(error.localizedDescription)
            }
        }
    }
    
    private func setError(_ message: String) {
        self.errorMessage = message
    }
}

extension CombineViewModel {
    func fetchRequestFromJSON() async {
        do {
            let container = try await client.fetchDataFromJson(type: ModelContainer<Model>.self, with: "model")
            self.employees = container.results.map{$0}
        } catch {
            self.setError(error.localizedDescription)
        }
    }
}
