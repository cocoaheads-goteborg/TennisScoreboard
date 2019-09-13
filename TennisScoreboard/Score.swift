enum Score {
    case love
    case fifteen
    case thirty
    case forty

    var text: String {
        switch self {
        case .love:
            return "Love"
        case .fifteen:
            return "15"
        case .thirty:
            return "30"
        case .forty:
            return "40"
        }
    }

    func incremented() -> Score {
        switch self {
        case .love:
            return .fifteen
        case .fifteen:
            return .thirty
        case .thirty:
            return .forty
        case .forty:
            fatalError()
        }
    }
}
