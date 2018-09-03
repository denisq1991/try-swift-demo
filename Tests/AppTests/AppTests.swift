import App
import XCTest

final class AppTests: XCTestCase {
    func testNothing() throws {
        // add your tests here
        XCTAssert(true)
    }
    
    
    // DQ this is just for linux tests
    static let allTests = [
        ("testNothing", testNothing)
    ]
}
