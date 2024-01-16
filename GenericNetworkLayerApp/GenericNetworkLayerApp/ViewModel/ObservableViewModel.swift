//
//  ObservableViewModel.swift
//  GenericNetworkLayerApp
//
//  Created by Jyoti - LetsWork on 1/15/24.
//

import Foundation

protocol ObservableViewModelProtocol {
    func fetchRequest() async
    func setError(_ message: String)
    var employees: Observable<[Model]> { get  set } //1
    var errorMessage: Observable<String?> { get set }
}

class ObservableViewModel : ObservableViewModelProtocol {
    private let client = HttpClient()
    var employees: Observable<[Model]> = Observable([])
    var errorMessage: Observable<String?> = Observable("")
    
    private var request : URLRequest = {
        let urlString =  "\(BASE_URL)/character"
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }()
    
    func fetchRequest() async {
        do {
            let container = try await client.fetchDataFromServer(type: ModelContainer<Model>.self , with: request)
            self.employees.value = container.results.map{$0}
        } catch {
            self.setError(error.localizedDescription)
        }
    }
    
    func setError(_ message: String) {
        self.errorMessage = Observable(message)
    }
}
