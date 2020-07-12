/// Represents the errors which can occur during the dice's initialization
enum DiceCreationError: Error, CustomStringConvertible {
    case insufficientNumberOfFaces
    case oddNumberOfFacess
    case tooManyFaces
    
    var description: String {
        switch self {
        case .insufficientNumberOfFaces:
            return "A dice should have at least 4 faces"
        case .oddNumberOfFacess:
            return "A dice should an even number of faces (multiple of 2)"
        case .tooManyFaces:
            return "A dice should at most 120 faces to be physically possible"
        }
    }
}
