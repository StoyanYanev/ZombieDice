public struct Dice<T: Equatable> {
    let faces: [T]
    
    init(faces: [T]) throws {
        guard faces.count > 3 else {
            throw DiceCreationError.insufficientNumberOfFaces
        }
        guard faces.count.isMultiple(of: 2) else {
            throw DiceCreationError.oddNumberOfFacess
        }
        guard faces.count <= 120 else {
            throw DiceCreationError.tooManyFaces
        }
        
        self.faces = faces;
    }
}

public extension Dice {
    func roll() -> T {
        return faces.shuffled()[0]
    }
}
