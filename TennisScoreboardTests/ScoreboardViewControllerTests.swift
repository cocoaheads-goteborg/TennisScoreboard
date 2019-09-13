import XCTest
@testable import TennisScoreboard

class ScoreboardViewControllerTests: XCTestCase {
    func test_initial_state_is_love() {
        let sut = makeLoadedScoreboard()

        XCTAssertEqual("Player 1: Love", sut.player1Label.text)
        XCTAssertEqual("Player 2: Love", sut.player2Label.text)
    }

    private func verifyPlayer1Score(tapTimes: Int, expectedScore: String, file: StaticString = #file, line: UInt = #line) {
        let sut = makeLoadedScoreboard()

        tap(sut.player1Increment, times: tapTimes)

        XCTAssertEqual("Player 1: \(expectedScore)", sut.player1Label.text, file: file, line: line)
    }

    func test_button_player1_increments_score_when_tapped() {
        verifyPlayer1Score(tapTimes: 1, expectedScore: "15")
        verifyPlayer1Score(tapTimes: 2, expectedScore: "30")
        verifyPlayer1Score(tapTimes: 3, expectedScore: "40")
        verifyPlayer1Score(tapTimes: 4, expectedScore: "Winner")
        verifyPlayer1Score(tapTimes: 5, expectedScore: "Winner")
    }

    private func verifyPlayer2Score(tapTimes: Int, expectedScore: String, file: StaticString = #file, line: UInt = #line) {
        let sut = makeLoadedScoreboard()

        tap(sut.player2Increment, times: tapTimes)

        XCTAssertEqual("Player 2: \(expectedScore)", sut.player2Label.text, file: file, line: line)
    }

    func test_button_player2_increments_score_when_tapped() {
        verifyPlayer2Score(tapTimes: 1, expectedScore: "15")
        verifyPlayer2Score(tapTimes: 2, expectedScore: "30")
        verifyPlayer2Score(tapTimes: 3, expectedScore: "40")
        verifyPlayer2Score(tapTimes: 4, expectedScore: "Winner")
        verifyPlayer2Score(tapTimes: 5, expectedScore: "Winner")
    }

    func test_equal_score_at_forty_is_deuce() {
        let sut = makeLoadedScoreboard()

        tap(sut.player1Increment, times: 3)
        tap(sut.player2Increment, times: 3)

        XCTAssertEqual("Player 1: Deuce", sut.player1Label.text)
        XCTAssertEqual("Player 2: Deuce", sut.player2Label.text)
    }

    func test_when_players_are_deuce_point_to_player2_will_give_adv() {
        let sut = makeLoadedScoreboard()

        tap(sut.player1Increment, times: 3)
        tap(sut.player2Increment, times: 3)

        tap(sut.player2Increment, times: 1)

        XCTAssertEqual("Player 1: 40", sut.player1Label.text)
        XCTAssertEqual("Player 2: Advantage", sut.player2Label.text)
    }

    func test_when_players_are_deuce_point_to_player1_will_give_adv() {
        let sut = makeLoadedScoreboard()

        tap(sut.player1Increment, times: 3)
        tap(sut.player2Increment, times: 3)

        tap(sut.player1Increment, times: 1)

        XCTAssertEqual("Player 1: Advantage", sut.player1Label.text)
        XCTAssertEqual("Player 2: 40", sut.player2Label.text)
    }

    func test_when_player1_is_at_adv_score_will_give_win() {
        let sut = makeLoadedScoreboard()

        tap(sut.player1Increment, times: 3)
        tap(sut.player2Increment, times: 3)
        tap(sut.player1Increment, times: 1) // adv

        tap(sut.player1Increment, times: 1)

        XCTAssertEqual("Player 1: Winner", sut.player1Label.text)
        XCTAssertEqual("Player 2: 40", sut.player2Label.text)
    }

    func test_when_player2_is_at_adv_score_will_give_win() {
        let sut = makeLoadedScoreboard()

        tap(sut.player1Increment, times: 3)
        tap(sut.player2Increment, times: 3)
        tap(sut.player2Increment, times: 1) // adv

        tap(sut.player2Increment, times: 1)

        XCTAssertEqual("Player 1: 40", sut.player1Label.text)
        XCTAssertEqual("Player 2: Winner", sut.player2Label.text)
    }

    func test_when_player2_is_at_adv_player1_score_will_deuce_game() {
        let sut = makeLoadedScoreboard()

        tap(sut.player1Increment, times: 3)
        tap(sut.player2Increment, times: 3)
        tap(sut.player1Increment, times: 1) // adv

        tap(sut.player2Increment, times: 1)

        XCTAssertEqual("Player 1: Deuce", sut.player1Label.text)
        XCTAssertEqual("Player 2: Deuce", sut.player2Label.text)
    }

    func test_when_player1_is_at_adv_player2_score_will_deuce_game() {
        let sut = makeLoadedScoreboard()

        tap(sut.player1Increment, times: 3)
        tap(sut.player2Increment, times: 3)
        tap(sut.player2Increment, times: 1) // adv

        tap(sut.player1Increment, times: 1)

        XCTAssertEqual("Player 1: Deuce", sut.player1Label.text)
        XCTAssertEqual("Player 2: Deuce", sut.player2Label.text)
    }

    func makeLoadedScoreboard() -> ScoreboardViewController {
        let scoreboard = ScoreboardViewController()
        scoreboard.loadViewIfNeeded()
        return scoreboard
    }

    func tap(_ button: UIControl, times: Int = 1) {
        (0..<times).forEach { (_) in
            button.sendActions(for: .touchUpInside)
        }
    }
}
