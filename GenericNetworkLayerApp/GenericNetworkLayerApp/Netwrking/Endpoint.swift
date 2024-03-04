//
//  Endpoint.swift
//  GenericNetworkLayerApp
//
//  Created by Jyoti - LetsWork on 1/12/24.
//

import Foundation

protocol Endpoint {
    var base : String {get}
    var path : String {get}
    var apiKey : String {get}
}

extension Endpoint {
    var apiKey: String {
        return "" // "api_key=34a92f7d77a168fdcd9a46ee1863edf1"
    }
    
    var queryItems : [URLQueryItem] {
       return [URLQueryItem(name: "page", value: "1")]
    }
    var urlComponents: URLComponents {
        var components = URLComponents()
        components.host = base
        components.scheme = "https"
        components.path = path
        components.queryItems = nil
        return components
    }

    var request : URLRequest {
        return URLRequest(url: urlComponents.url!)
    }
}

enum APIs {
    case characters
}
extension APIs: Endpoint {
    var base: String {
        return "rickandmortyapi.com"
    }
    var path: String {
        switch self {
        case .characters: return "/api/character"
        }
    }
}

let BASE_URL = "https://rickandmortyapi.com/api"



