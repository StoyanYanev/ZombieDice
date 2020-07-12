public class Player {
    private var name: String
    private var brainScore: Int
    private var shotgunScore: Int
    private var hand: Hand
    
    init(name: String){
        self.name = name
        self.brainScore = 0
        self.shotgunScore = 0
        self.hand = Hand()
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func getBrainScore() -> Int {
        return self.brainScore
    }
    
    func getHand() -> Hand {
        return self.hand
    }
    
    public func updateBrainScore(numberOfBrains: Int) {
        self.brainScore += numberOfBrains
    }
    
    public func getShotgunScore() -> Int {
        return self.shotgunScore
    }
    
    public func updateNumberOfShotguns(numberOfShotguns: Int) {
        self.shotgunScore += numberOfShotguns
    }
    
    public func resetNumberOfShotguns(){
        self.shotgunScore = 0
    }
}

extension Player: Equatable {
    public static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.getName() == rhs.getName() && lhs.getBrainScore() == rhs.getBrainScore()
            &&  lhs.getShotgunScore() == rhs.getShotgunScore()
    }
}
