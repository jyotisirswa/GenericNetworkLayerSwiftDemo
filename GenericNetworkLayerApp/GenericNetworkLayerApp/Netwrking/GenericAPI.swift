//
//  GenericAPI.swift
//  GenericNetworkLayerApp
//
//  Created by Jyoti - LetsWork on 1/12/24.
//

import Foundation
import UIKit

enum APIError : Error {
    case requestFailed(description : String)
    case responseUnSucessful(description : String)
    case invalidData
    case jsonConversionFailed(description : String)
    case noInternate
    case imageLoadingError(description : String)
    case invalidURLError(description : String)
    
    var customDescription : String {
        switch self {
        case .requestFailed(description: let description):
            return "Request failed Error : \(description)"
        case .responseUnSucessful(description: let description):
            return "Response Unscuccessful : \(description)"
        case .invalidData:
            return "Invalid Data"
        case .jsonConversionFailed(description: let description):
            return "JSON Conversion Error : \(description)"
        case .noInternate:
            return "No Internet connection"
        case .imageLoadingError(description: let description):
            return "Image Loading Error : \(description)"
        case .invalidURLError(description: let description):
            return "Invalid URL : \(description)"
        }
    }
}

protocol AsyncGenericNetworkLayer   {
    var session : URLSession {get}
    func fetchDataFromServer<T : Decodable>(type : T.Type, with request : URLRequest) async throws -> T
    func fetchDataFromJson<T : Decodable>(type : T.Type, with fileName : String, from bundle: Bundle) async throws -> T

}
protocol AsyncDownloadImageFromServerProtocol {
    func downloadImage(from urlString: String) async -> UIImage?
}

extension AsyncGenericNetworkLayer {
    
    @MainActor
    func fetchDataFromServer<T : Decodable>(type : T.Type, with request : URLRequest) async throws -> T {
        //1
        print("---Calling api 3--")
        let (data, response) = try await session.data(for: request) //this function returns optional data, response & throws error thats why it marked as try //we write await in front of the call to mark the possible suspension point. asynchronours function which return data & response two params. the flow of execution is suspended only when you call another asynchronous method — suspension is never implicit or preemptive — which means every possible suspension point is marked with await.The possible suspension points in your code marked with await indicate that the current piece of code might pause execution while waiting for the asynchronous function or method to return. This is also called yielding the thread because, behind the scenes, Swift suspends the execution of your code on the current thread and runs some other code on that thread instead.
        print("---Calling api 6--")
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed(description: request.description)
        }
        guard httpResponse.statusCode == 200 else {
            throw APIError.responseUnSucessful(description: "\(httpResponse.statusCode)")
        }
        do { //inside this we return docoded value if the decoding is successfull else we throw
            let jsonDecoder = JSONDecoder()
            print("---Calling api 7--")
            print(try jsonDecoder.decode(type, from: data))
            return try jsonDecoder.decode(type, from: data)
        } catch {
            throw APIError.jsonConversionFailed(description: error.localizedDescription)
        }
    }
    
    func fetchDataFromJson<T : Decodable>(type : T.Type, with fileName : String, from bundle: Bundle = .main) async throws -> T {
        guard let url = bundle.url(forResource: "jsonfile", withExtension: "json") else {
            throw APIError.invalidURLError(description: "\(fileName).json")
        }
        let data = try Data(contentsOf: url)
        do {
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode(type, from: data)
        } catch {
            throw APIError.jsonConversionFailed(description: error.localizedDescription)
        }
    }
}


/*
 /*
  let photos = await withTaskGroup(of: Data.self) { group in
      let photoNames = await listPhotos(inGallery: "Summer Vacation")
      for name in photoNames {
          group.addTask {
              return await downloadPhoto(named: name)
          }
      }
      var results: [Data] = []
      for await photo in group {
          results.append(photo)
      }
      return results
  }
  */
 
 /*let photos = await withTaskGroup(of: Optional<Data>.self) { group in
     let photoNames = await listPhotos(inGallery: "Summer Vacation")
     for name in photoNames {
         group.addTaskUnlessCancelled {
             guard isCancelled == false else { return nil }
             return await downloadPhoto(named: name)
         }
     }


     var results: [Data] = []
     for await photo in group {
         if let photo { results.append(photo) }
     }
     return results
  
  In a parent task, you can’t forget to wait for its child tasks to complete.
  When setting a higher priority on a child task, the parent task’s priority is automatically escalated.
  When a parent task is canceled, each of its child tasks is also automatically canceled.
  Task-local values propagate to child tasks efficiently and automatically.
  
  Task.checkCancellation()
  Task.isCancelled
  Each task is added using the TaskGroup.addTaskUnlessCancelled(priority:operation:) method, to avoid starting new work after cancellation.
  let photos = await withTaskGroup(of: Optional<Data>.self) { group in
      let photoNames = await listPhotos(inGallery: "Summer Vacation")
      for name in photoNames {
          group.addTaskUnlessCancelled {
              guard isCancelled == false else { return nil }
              return await downloadPhoto(named: name)
          }
      }


      var results: [Data] = []
      for await photo in group {
          if let photo { results.append(photo) }
      }
      return results
  }
  
  For work that needs immediate notification of cancellation, use the Task.withTaskCancellationHandler(operation:onCancel:) method
  let task = await Task.withTaskCancellationHandler {
      // ...
  } onCancel: {
      print("Canceled!")
  }


  // ... some time later...
  task.cancel()
  
  Unstructured Concurrency
  To create an unstructured task that runs on the current actor, call the Task.init(priority:operation:) initializer. To create an unstructured task that’s not part of the current actor, known more specifically as a detached task, call the Task.detached(priority:operation:) class method.
  
  
 } */
}
 let firstPhoto = await downloadPhoto(named: photoNames[0])
 let secondPhoto = await downloadPhoto(named: photoNames[1])
 let thirdPhoto = await downloadPhoto(named: photoNames[2])


 let photos = [firstPhoto, secondPhoto, thirdPhoto]
 show(photos)
 
 async let firstPhoto = downloadPhoto(named: photoNames[0])
 async let secondPhoto = downloadPhoto(named: photoNames[1])
 async let thirdPhoto = downloadPhoto(named: photoNames[2])

 let photos = await [firstPhoto, secondPhoto, thirdPhoto]
 show(photos)
 
 Call asynchronous functions with await when the code on the following lines depends on that function’s result. This creates work that is carried out sequentially.
 Call asynchronous functions with async-let when you don’t need the result until later in your code. This creates work that can be carried out in parallel.
 Both await and async-let allow other code to run while they’re suspended.
 In both cases, you mark the possible suspension point with await to indicate that execution will pause, if needed, until an asynchronous function has returned.
 */
