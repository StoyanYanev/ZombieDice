enum BasicGameDieFaces: String, CustomStringConvertible, Hashable {
    case brains = "🧠"
    case shotgun = "💥"
    case runner = "👣"

    var description: String {
        get {
            return self.rawValue
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


public final class ZombieDiceGame {
    static let greenDie = try! Die(faces: Array(repeating: BasicGameDieFaces.brains, count: MAX_BRAINS_IN_GREEN_DIE) + 
                                          Array(repeating: BasicGameDieFaces.shotgun, count: MAX_SHOTGUNS_IN_GREEN_DIE) + Array(repeating: BasicGameDieFaces.runner, count: MAX_RUNNERS_IN_GREEN_DIE))

    static let yelloDie = try! Die(faces: Array(repeating: BasicGameDieFaces.brains, count: MAX_BRAINS_IN_YELLO_DIE) + 
                                          Array(repeating: BasicGameDieFaces.shotgun, count: MAX_SHOTGUNS_IN_YELLO_DIE) + Array(repeating: BasicGameDieFaces.runner, count: MAX_RUNNERS_IN_YELLO_DIE))                                      

    static let redDie = try! Die(faces: Array(repeating: BasicGameDieFaces.brains, count: MAX_BRAINS_IN_RED_DIE) + 
                                          Array(repeating: BasicGameDieFaces.shotgun, count: MAX_SHOTGUNS_IN_RED_DIE) + 
                                          Array(repeating: BasicGameDieFaces.runner, count: MAX_RUNNERS_IN_RED_DIE))  

    let gameDicePool = Array(repeating: greenDie, count: MAX_GREEN_DIE_IN_GAME) + Array(repeating: yelloDie, count: MAX_YELLO_DIE_IN_GAME)
                       + Array(repeating: redDie, count: MAX_RED_DIE_IN_GAME)

    public init() {}

    func drawAndRoll(_ numberOfDice: Int, dicePool: [Die<BasicGameDieFaces>]) -> [BasicGameDieFaces] { //TODO
        let hand = dicePool.shuffled().prefix(numberOfDice)
        var greenDiceHand = 0
        var yellowDiceInHand = 0
        var redDiceInHand = 0

        for dice in hand {
            print(dice.faces.histogram)
            let numberOfBrainFacesOnDie = dice.faces.histogram.first{$0.key.description == BasicGameDieFaces.brains.description}.map{$0.value}
            if numberOfBrainFacesOnDie == MAX_BRAINS_IN_GREEN_DIE {
                greenDiceHand += 1
            } else if(numberOfBrainFacesOnDie == MAX_BRAINS_IN_YELLO_DIE) {
                yellowDiceInHand += 1
            } else {
                redDiceInHand += 1
            }
        }
        print("Pulled \(greenDiceHand) green dice; \(yellowDiceInHand) yellow dice; \(redDiceInHand) red dice;")
        let result = hand.map{$0.roll()}
        print("Rolled \(BasicGameDieFaces.brains.description) \(result.filter{$0.description == BasicGameDieFaces.brains.description}.count); \(BasicGameDieFaces.shotgun.description) \(result.filter{$0.description == BasicGameDieFaces.shotgun.description}.count); \(BasicGameDieFaces.runner.description) \(result.filter{$0.description == BasicGameDieFaces.runner.description}.count)")
        
        return result
    }

    public func run() throws {
        let _ = drawAndRoll(START_DIES_IN_GAME, dicePool: gameDicePool)
    }
}
