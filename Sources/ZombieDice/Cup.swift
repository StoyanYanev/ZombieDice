/// The responsibility of the Cup class is to store all dices during the game
public class Cup {
    /// Stores all 13 game's dices
    private let gameDicePool = Array(repeating: Dices.greenDice, count: CupConstants.MAX_GREEN_DICE_IN_GAME) + Array(repeating: Dices.yellowDice, count: CupConstants.MAX_YELLOW_DICE_IN_GAME)
        + Array(repeating: Dices.redDice, count: CupConstants.MAX_RED_DICE_IN_GAME)
    
    /// Stores the game's dices without the dices that has been pulled by the current player
    private var currentDicePool: [Dice<GameDiceFaces>]
    
    init() {
        self.currentDicePool = gameDicePool
    }
    
    /// Returns the pulled dices from the cup
    ///
    /// - Parameters: numberOfDice - the number of dices that should be pulled from the cup
    /// - Returns: the pulled dices
    func pullDices(_ numberOfDice: Int) -> Array<Dice<GameDiceFaces>> {
        let hand = currentDicePool.shuffled().prefix(numberOfDice)
        var greenDicesInHand = 0
        var yellowDicesInHand = 0
        var redDicesInHand = 0
        
        for dice in hand {
            let numberOfBrainFacesOnDice = dice.faces.histogram.first{$0.key.description == GameDiceFaces.brains.description}.map{$0.value}
            if numberOfBrainFacesOnDice == CupConstants.MAX_BRAINS_IN_GREEN_DICE {
                greenDicesInHand += 1
            } else if(numberOfBrainFacesOnDice == CupConstants.MAX_BRAINS_IN_YELLOW_DICE) {
                yellowDicesInHand += 1
            } else {
                redDicesInHand += 1
            }
        }
        print("Pulled \(greenDicesInHand) 🟢 dice; \(yellowDicesInHand) 🟡 dice; \(redDicesInHand) 🔴 dice;")
        updateDicePool(pulledDices: Array(hand))
        
        return Array(hand)
    }
    
    /// Returns the dices in the cup after the player finishes his turn
    public func returnDicesInCup() {
        self.currentDicePool = gameDicePool
    }
    
    /// Updates the current dice pool by removing the pulled dices from it
    ///
    /// - Parameters: pulledDices - the dices that the player has pulled
    internal func updateDicePool(pulledDices: Array<Dice<GameDiceFaces>>){
        for dice in pulledDices {
            if let index = currentDicePool.firstIndex(where: { $0.faces == dice.faces }) {
                currentDicePool.remove(at: index)
            }
        }
    }
}

extension Sequence where Element: Hashable {
    var histogram: [Element: Int] {
        return self.reduce(into: [:]) { counts, elem in counts[elem, default: 0] += 1 }
    }
    
    func frequency(of element: Element) -> Int {
        return histogram[element] ?? 0
    }
}
