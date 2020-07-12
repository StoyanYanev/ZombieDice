enum InputError: Error, CustomStringConvertible {
    case invalidNumberOfPlayers
    case invalidChoice
    
    var description: String {
        switch self {
        case .invalidNumberOfPlayers:
            return "The number of players must be between 2-8!"
        case .invalidChoice:
            return "Your choice was invalid!"
        }
    }
}
