enum DiceCreationError: Error, CustomStringConvertible {
    case insufficientNumberOfFaces
    case oddNumberOfFacess
    case tooManyFaces
    
    var description: String {
        switch self {
        case .insufficientNumberOfFaces:
            return "A die should have at least 4 faces"
        case .oddNumberOfFacess:
            return "A die should an even number of faces (multiple of 2)"
        case .tooManyFaces:
            return "A die should at most 120 faces to be physically possible"
        }
    }
}
