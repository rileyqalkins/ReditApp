import XCTest
@testable import ReditApp

class ReditViewModelSpec: XCTestCase {

    let reditViewModel = ReditViewModel()
    
    override func setUpWithError() throws {
        reditViewModel.reditPosts = [
            RedditPost(),
            RedditPost(),
            RedditPost(),
            RedditPost(),
            RedditPost(),
            RedditPost(),
            RedditPost(),
            RedditPost(),
            RedditPost(),
            RedditPost()
        ]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testisRefreshRequired() throws {
        XCTAssertFalse(reditViewModel.isRefreshRequired(for: 5))
        
        XCTAssertTrue(reditViewModel.isRefreshRequired(for: 8))
        
        XCTAssertFalse(reditViewModel.isRefreshRequired(for: 0))
        
        XCTAssertTrue(reditViewModel.isRefreshRequired(for: 9))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
