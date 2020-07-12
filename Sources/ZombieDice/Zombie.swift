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
    
    public func updateBrainScore(numberOfBrains: Int) {
        self.brainScore += numberOfBrains
    }
    
    public func updateNumberOfShotguns(numberOfShotguns: Int) {
        self.shotgunScore += numberOfShotguns
    }
    
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
