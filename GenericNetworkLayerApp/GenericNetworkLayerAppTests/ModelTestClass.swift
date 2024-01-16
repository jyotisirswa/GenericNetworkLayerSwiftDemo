//
//  ModelTestClass.swift
//  GenericNetworkLayerAppTests
//
//  Created by Jyoti - LetsWork on 1/15/24.
//

import XCTest
@testable import GenericNetworkLayerApp

final class ModelTestClass: XCTestCase {
    
    var bundle: Bundle!
    let client = HttpClient()

    
    override func setUp() {
        bundle = Bundle(for: ModelTestClass.self)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSingleModelJSON() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        guard let url = bundle.url(forResource: "model", withExtension: "json") else {
            XCTFail("Missing file name : model.json")
            return
        }
        let json = try Data(contentsOf: url)
        let model = try! JSONDecoder().decode(ModelContainer<Model>.self , from: json)
        XCTAssertEqual(model.results.first?.name , "Rick Sanchez")
        XCTAssertEqual(model.results.first?.status, "Alive")
    }
    
    func testModelResponseJSONMapping() {
        guard let url = bundle.url(forResource: "modeljson", withExtension: "json") else {
            XCTFail("Missing file: modeljson.json")
            return
        }
        let json = try! Data(contentsOf: url)
        let model = try! JSONDecoder().decode(ModelContainer<Model>.self, from: json)
        XCTAssertEqual(model.results.first?.name, "Rick Sanchez")
        XCTAssertEqual(model.results.first?.status, "Alive")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
