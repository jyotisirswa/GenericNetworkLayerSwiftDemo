//
//  HttpClient.swift
//  GenericNetworkLayerApp
//
//  Created by Jyoti - LetsWork on 1/12/24.
//

import Foundation
/* but can be marked as such are immutable classes and classes with internal locking mechanism HTTPCLient is immutable and therefore thread-safe, so can conform to Sendable
 Non-final class ‘User’ cannot conform to `Sendable`; use `@unchecked Sendable`
*/
final class HttpClient : Sendable, AsyncGenericNetworkLayer {
    let session: URLSession
    private init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    convenience init() {
        self.init(configuration: .default)
    }
}
