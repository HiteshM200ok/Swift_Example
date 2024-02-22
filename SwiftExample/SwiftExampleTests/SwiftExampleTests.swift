//
//  SwiftExampleTests.swift
//  SwiftExampleTests
//
//  Created by 200OK-IOS5 on 31/01/24.
//

import XCTest
@testable import SwiftExample

final class SwiftExampleTests: XCTestCase {
    let userName: String? = Constant.dummyuserName
    let password: String? = Constant.dummyPassword
    let productDataSource = ProductTableDataSource()
    var productView : ProductViewScreen? = nil

    var authViewModel: AuthViewModel?
    var productViewModel: ProductViewModel?

    override func setUpWithError() throws {
        productView = ProductViewScreen(nibName: "ProductViewScreen", bundle: Bundle.main)
     
        authViewModel = AuthViewModel()
        productViewModel = ProductViewModel()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        authViewModel = nil
        productViewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func getProduct() throws {
        productViewModel?.getAllProducts { product, error in
            XCTAssertNotNil(product)
        }
    }
    
    func authUser(){
        authViewModel?.signIn(username: userName!, password: password!) { data, error in
            print(error?.first?.debugDescription ?? "error")
        }
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        do {
            try getProduct()
            
        } catch let error{
            print(error.localizedDescription)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            authUser()
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchPostList() {
            let exp = expectation(description:"fetching post list from server")
            let session: URLSession = URLSession(configuration: .default)
            let url = URL(string: Constant.baseUrl+APIEndPoints.products.url)
            guard let customUrl = url else { return }
            
            session.dataTask(with: customUrl) { data, response, error in
                XCTAssertNotNil(data)
                exp.fulfill()
            }.resume()
            waitForExpectations(timeout: 5.0) { (error) in
                print(error?.localizedDescription ?? "error")
            }
        }

}
