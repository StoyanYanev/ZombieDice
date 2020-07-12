let MAX_BRAINS_IN_GREEN_DIE = 3
let MAX_SHOTGUNS_IN_GREEN_DIE = 1
let MAX_RUNNERS_IN_GREEN_DIE = 2

let MAX_BRAINS_IN_YELLO_DIE = 2
let MAX_SHOTGUNS_IN_YELLO_DIE = 2
let MAX_RUNNERS_IN_YELLO_DIE = 2

let MAX_BRAINS_IN_RED_DIE = 1
let MAX_SHOTGUNS_IN_RED_DIE = 3
let MAX_RUNNERS_IN_RED_DIE = 2

let MAX_GREEN_DIE_IN_GAME = 6
let MAX_YELLO_DIE_IN_GAME = 4
let MAX_RED_DIE_IN_GAME = 3

let START_DIES_IN_GAME = 3

public class Cup {
    static let greenDice = try! Dice(faces: Array(repeating: GameDiceFaces.brains, count: MAX_BRAINS_IN_GREEN_DIE) + 
        Array(repeating: GameDiceFaces.shotgun, count: MAX_SHOTGUNS_IN_GREEN_DIE) + Array(repeating: GameDiceFaces.runner, count: MAX_RUNNERS_IN_GREEN_DIE))
    
    static let yelloDice = try! Dice(faces: Array(repeating: GameDiceFaces.brains, count: MAX_BRAINS_IN_YELLO_DIE) + 
        Array(repeating: GameDiceFaces.shotgun, count: MAX_SHOTGUNS_IN_YELLO_DIE) + Array(repeating: GameDiceFaces.runner, count: MAX_RUNNERS_IN_YELLO_DIE))
    
    static let redDice = try! Dice(faces: Array(repeating: GameDiceFaces.brains, count: MAX_BRAINS_IN_RED_DIE) + 
        Array(repeating: GameDiceFaces.shotgun, count: MAX_SHOTGUNS_IN_RED_DIE) +
        Array(repeating: GameDiceFaces.runner, count: MAX_RUNNERS_IN_RED_DIE))
    
    let gameDicePool = Array(repeating: greenDice, count: MAX_GREEN_DIE_IN_GAME) + Array(repeating: yelloDice, count: MAX_YELLO_DIE_IN_GAME)
        + Array(repeating: redDice, count: MAX_RED_DIE_IN_GAME)
    
    private var currentDicePool: [Dice<GameDiceFaces>]
    
    public init() {
        self.currentDicePool = gameDicePool
    }
    
    func pullDices(_ numberOfDice: Int) -> Array<Dice<GameDiceFaces>> {
        let hand = currentDicePool.shuffled().prefix(numberOfDice)
        var greenDiceHand = 0
        var yellowDiceInHand = 0
        var redDiceInHand = 0
        
        for dice in hand {
            let numberOfBrainFacesOnDie = dice.faces.histogram.first{$0.key.description == GameDiceFaces.brains.description}.map{$0.value}
            if numberOfBrainFacesOnDie == MAX_BRAINS_IN_GREEN_DIE {
                greenDiceHand += 1
            } else if(numberOfBrainFacesOnDie == MAX_BRAINS_IN_YELLO_DIE) {
                yellowDiceInHand += 1
            } else {
                redDiceInHand += 1
            }
        }
        print("Pulled \(greenDiceHand) green dice; \(yellowDiceInHand) yellow dice; \(redDiceInHand) red dice;")
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
