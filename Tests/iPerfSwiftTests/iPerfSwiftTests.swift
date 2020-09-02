import XCTest
@testable import iPerfSwift

final class iPerfSwiftTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        guard let test = Test() else {
            XCTFail("Failed to create test!")
            return
        }

        test.role = .server


    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
