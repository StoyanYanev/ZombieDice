protocol Player {
    var name: String {get}
    var brainScore: Int {get}
    var shotgunScore: Int {get}
    var hand: Hand {get}
    
    init(name: String)
    
    func updateBrainScore(numberOfBrains: Int)
    func updateNumberOfShotguns(numberOfShotguns: Int)
    func resetNumberOfShotguns()
}
