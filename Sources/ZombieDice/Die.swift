enum DieCreationError: Error, CustomStringConvertible {
    case insufficientNumberOfFaces
    case oddNumberOfFacess
    case tooManyFaces

    var description: String {
        switch self {
        case .insufficientNumberOfFaces:
            return "A die should have at least 4 faces"
        case .oddNumberOfFacess:
            return "A die should an even number of faces (multiple of 2)"
        case .tooManyFaces:
            return "A die should at most 120 faces to be physically possible"
        }
    }
}

public struct Die<T> {
    let faces: [T]
    
    init(faces: [T]) throws {
        guard faces.count > 3 else {
            throw DieCreationError.insufficientNumberOfFaces
        }
        guard faces.count.isMultiple(of: 2) else {
            throw DieCreationError.oddNumberOfFacess
        }
        guard faces.count <= 120 else {
            throw DieCreationError.tooManyFaces
        }

        self.faces = faces;
    }
}

public extension Die {
    func roll() -> T {
        return faces.shuffled()[0]
    }
    
}

// enum BasicGameDieFaces: String, CustomStringConvertible, Hashable {
//     case brains = "🧠"
//     case shotgun = "💥"
//     case runner = "👣"

//     var description: String {
//         get {
//             return self.rawValue
//         }
//     }
// }

// extension Sequence where Element: Hashable {
//     var histogram: [Element: Int] {
//         return self.reduce(into: [:]) { counts, elem in counts[elem, default: 0] += 1 }
//     }

//     func frequency(of element: Element) -> Int {
//         return histogram[element] ?? 0
//     }
// }

// public final class ZombieDiceGame {
//     static let greenDie = try! Die(faces: Array(repeating: BasicGameDieFaces.brains, count: 3) + 
//                                           Array(repeating: BasicGameDieFaces.shotgun, count: 1) + 
//                                           Array(repeating: BasicGameDieFaces.runner, count: 2))

//     static let yelloDie = try! Die(faces: Array(repeating: BasicGameDieFaces.brains, count: 2) + 
//                                           Array(repeating: BasicGameDieFaces.shotgun, count: 2) + 
//                                           Array(repeating: BasicGameDieFaces.runner, count: 2))                                      

//     static let redDie = try! Die(faces: Array(repeating: BasicGameDieFaces.brains, count: 1) + 
//                                           Array(repeating: BasicGameDieFaces.shotgun, count: 3) + 
//                                           Array(repeating: BasicGameDieFaces.runner, count: 2))  

//     let gameDicePool = Array(repeating: greenDie, count: 6) + Array(repeating: yelloDie, count: 4)
//                        + Array(repeating: redDie, count: 3)

//     public init() {}

//     func drawAndRoll(_ numberOfDice: Int, dicePool: [Die<BasicGameDieFaces>]) -> [Die<BasicGameDieFaces>] {
//         let hand = dicePool.shuffled().prefix(numberOfDice)
//         var greenDiceHand = 0
//         var yellowDiceInHand = 0
//         var redDiceInHand = 0

//         for dice in hand {
//             print(dice.faces.histogram)
//             let numberOfFaces = dice.faces.histogram.first{$0.key.description == "🧠"}.map{$0.value}
//             if numberOfFaces == 3 {
//                 greenDiceHand += 1
//             }else if(numberOfFaces == 2) {
//                 yellowDiceInHand += 1
//             } else {
//                 redDiceInHand += 1
//             }
//         }
//         //let greenDiceInHand = hand.filter{$0.faces.histogram.count(of: "🧠") == Self.greenDie.faces.histogram.count(of: "🧠")}.count
//         // let yellowDiceInHand = hand.filter {$0.faces.count(of: .brains) == Self.yellow.faces.count(of: .brains)}.count
//         // let redDiceInHand = hand.filter {$0.faces.count(of: .brains) == Self.red.faces.count(of: .brains)}.count
//         print("Pulled \(greenDiceHand) green dice; \(yellowDiceInHand) yellow dice; \(redDiceInHand) red dice;")
//         let result = hand.map{$0.roll()}
//         print("Rolled \(BasicGameDieFaces.brains.description) \(result.filter{$0.description == BasicGameDieFaces.brains.description}.count); \(BasicGameDieFaces.shotgun.description) \(result.filter{$0.description == BasicGameDieFaces.shotgun.description}.count); \(BasicGameDieFaces.runner.description) \(result.filter{$0.description == BasicGameDieFaces.runner.description}.count)")
        
//         return dicePool
//     }

//     public func run() throws {
//         let _ = drawAndRoll(3, dicePool: gameDicePool)
//     }
// }

// let game = ZombieDiceGame()
// do {
//    try game.run()
// } catch  {
//     print("asds")
// }