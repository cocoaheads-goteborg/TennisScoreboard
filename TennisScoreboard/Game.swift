enum Game {
    case earlyGame(Score, Score)
    case deuce
    case advantagePlayer1
    case advantagePlayer2
    case winnerPlayer1
    case winnerPlayer2

    mutating func incrementPlayer1() {
        switch self {
        case .earlyGame(.thirty, .forty):
            self = .deuce
        case .earlyGame(.forty, _):
            self = .winnerPlayer1
        case .earlyGame(let player1, let player2):
            self = .earlyGame(player1.incremented(), player2)
        case .deuce:
            self = .advantagePlayer1
        case .winnerPlayer1:
            self = .winnerPlayer1
        case .winnerPlayer2:
            fatalError()
        case .advantagePlayer1:
            self = .winnerPlayer1
        case .advantagePlayer2:
            self = .deuce
        }
    }

    mutating func incrementPlayer2() {
        switch self {
        case .earlyGame(.forty, .thirty):
            self = .deuce
        case .earlyGame(_, .forty):
            self = .winnerPlayer2
        case .earlyGame(let player1, let player2):
            self = .earlyGame(player1, player2.incremented())
        case .deuce:
            self = .advantagePlayer2
        case .winnerPlayer1:
            fatalError()
        case .winnerPlayer2:
            self = .winnerPlayer2
        case .advantagePlayer1:
            self = .deuce
        case .advantagePlayer2:
            self = .winnerPlayer2
        }
    }
}
