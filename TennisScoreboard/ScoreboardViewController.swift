import UIKit

class ScoreboardViewController: UIViewController {
    let player1Label = UILabel()
    let player2Label = UILabel()

    let player1Increment = UIButton()
    let player2Increment = UIButton()

    private var game: Game = .earlyGame(.love, .love)

    override func viewDidLoad() {
        super.viewDidLoad()

        updateLabels()

        player1Increment.addTarget(self,
                                   action: #selector(incrementPlayer1Score),
                                   for: .touchUpInside)
        player2Increment.addTarget(self,
                                   action: #selector(incrementPlayer2Score),
                                   for: .touchUpInside)

    }

    @objc
    private func incrementPlayer1Score() {
        game.incrementPlayer1()
        updateLabels()
    }

    @objc
    private func incrementPlayer2Score() {
        game.incrementPlayer2()
        updateLabels()
    }

    private func updateLabels() {
        switch game {
        case .earlyGame(let score1, let score2):
            player1Label.text = "Player 1: \(score1.text)"
            player2Label.text = "Player 2: \(score2.text)"
        case .deuce:
            player1Label.text = "Player 1: Deuce"
            player2Label.text = "Player 2: Deuce"
        case .winnerPlayer1:
            player1Label.text = "Player 1: Winner"
        case .winnerPlayer2:
            player2Label.text = "Player 2: Winner"
        case .advantagePlayer1:
            player1Label.text = "Player 1: Advantage"
            player2Label.text = "Player 2: 40"
        case .advantagePlayer2:
            player1Label.text = "Player 1: 40"
            player2Label.text = "Player 2: Advantage"
        }
    }
}
