import XCTest
@testable import ConfigureID_iOS_SDK

final class ConfigureID_iOS_SDKTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        XCTAssertEqual(ConfigureID_iOS_SDK().text, "Hello, World!")
        let exp = expectation(description: "Loading stories")
        ConfigureID.setApiKey(apiKey: "<API_KEY>")
        
        
//        ConfigureID
//            .Customers
//            .fetchProducts(customerId: "1622", onSuccess: {
//                print($0)
//                exp.fulfill()
//                    }, onError: {
//                        print($0)
//                        exp.fulfill()
//                    })
        
//        ConfigureID
//            .Customers
//            .fetchProductData(customerId: "1622", productId: "24253", onSuccess: {
//                print($0)
//                exp.fulfill()
//            }, onError: {
//                print($0)
//                exp.fulfill()
//            })
        
        waitForExpectations(timeout: 10)
        
    }
}
