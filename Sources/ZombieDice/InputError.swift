enum InputError: Error, CustomStringConvertible {
    case invalidNumberOfPlayers
    case invalidChooice
    
    var description: String {
        switch self {
        case .invalidNumberOfPlayers:
            return "The number of players must be between 2-8!"
        case .invalidChooice:
            return "Your choose was invalid!"
        }
    }
}
