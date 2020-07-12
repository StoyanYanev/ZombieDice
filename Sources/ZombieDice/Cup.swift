public class Cup {
    private let gameDicePool = Array(repeating: Dices.greenDice, count: CupConstants.MAX_GREEN_DICE_IN_GAME) + Array(repeating: Dices.yellowDice, count: CupConstants.MAX_YELLOW_DICE_IN_GAME)
        + Array(repeating: Dices.redDice, count: CupConstants.MAX_RED_DICE_IN_GAME)
    
    private var currentDicePool: [Dice<GameDiceFaces>]
    
    public init() {
        self.currentDicePool = gameDicePool
    }
    
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
        print("Pulled \(greenDicesInHand) green dice; \(yellowDicesInHand) yellow dice; \(redDicesInHand) red dice;")
        updateDicePool(pulledDices: Array(hand))
        
        return Array(hand)
    }
    
    public func returnDicesInCup(){
        self.currentDicePool = gameDicePool
    }
    
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
