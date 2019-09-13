import XCTest
@testable import TennisScoreboard

class TennisScoreboardTests: XCTestCase {
    func test_show_scoreboard_on_start() {
        let root = UIApplication.shared.keyWindow?.rootViewController

        XCTAssertTrue(root is ScoreboardViewController)
    }
}
