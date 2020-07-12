struct Dices {
    static let greenDice = try! Dice(faces: Array(repeating: GameDiceFaces.brains, count: CupConstants.MAX_BRAINS_IN_GREEN_DICE) +
        Array(repeating: GameDiceFaces.shotgun, count: CupConstants.MAX_SHOTGUNS_IN_GREEN_DICE) + Array(repeating: GameDiceFaces.runner, count: CupConstants.MAX_RUNNERS_IN_GREEN_DICE))
    
    static let yellowDice = try! Dice(faces: Array(repeating: GameDiceFaces.brains, count: CupConstants.MAX_BRAINS_IN_YELLOW_DICE) +
        Array(repeating: GameDiceFaces.shotgun, count: CupConstants.MAX_SHOTGUNS_IN_YELLOW_DICE) + Array(repeating: GameDiceFaces.runner, count: CupConstants.MAX_RUNNERS_IN_YELLOW_DICE))
    
    static let redDice = try! Dice(faces: Array(repeating: GameDiceFaces.brains, count: CupConstants.MAX_BRAINS_IN_RED_DICE) +
        Array(repeating: GameDiceFaces.shotgun, count: CupConstants.MAX_SHOTGUNS_IN_RED_DICE) +
        Array(repeating: GameDiceFaces.runner, count: CupConstants.MAX_RUNNERS_IN_RED_DICE))
    
}
