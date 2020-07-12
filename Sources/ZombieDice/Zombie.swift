public class Zombie: Player {
    var name: String
    var brainScore: Int
    var shotgunScore: Int
    var hand: Hand
    
    required init(name: String) {
        self.name = name
        self.brainScore = 0
        self.shotgunScore = 0
        self.hand = Hand()
    }
    
    /// Updates the brain score by adding the number of the brains from the dices which the player has rolled
    ///
    /// - Parameters: numberOfBrains
    public func updateBrainScore(numberOfBrains: Int) {
        self.brainScore += numberOfBrains
    }
    
    /// Updates the shot guns score by adding the number of the guns from the dices which the player has rolled
    ///
    /// - Parameters: numberOfShotGuns
    public func updateNumberOfShotguns(numberOfShotguns: Int) {
        self.shotgunScore += numberOfShotguns
    }
    
    /// Resets the number of shot guns. It is used when the player ends his turn
    public func resetNumberOfShotguns() {
        self.shotgunScore = 0
    }
}

extension Zombie: Equatable {
    public static func == (lhs: Zombie, rhs: Zombie) -> Bool {
        lhs.name == rhs.name && lhs.brainScore == rhs.brainScore
            &&  lhs.shotgunScore == rhs.shotgunScore
    }
}
