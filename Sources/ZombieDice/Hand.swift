/// Stores the dices that a player has pulled from the cup
public class Hand {
    /// The pulled dices by a player
    private var dices: [Dice<GameDiceFaces>]
    
    init() {
        self.dices = [Dice<GameDiceFaces>]()
    }
    
    /// Returns the faces of the dices that the player has rolled
    ///
    /// - Parameters: pulledDices
    /// - Returns: an array with the dice's faces
    func rollDices(pulledDices: Array<Dice<GameDiceFaces>>) -> [GameDiceFaces] {
        dices = dices + pulledDices;
        let result = dices.map{$0.roll()}
        var rolledRunners = [Dice<GameDiceFaces>]()
        var index = 0
        for runner in result {
            /// If there is a runner face the dice will stay in the dices
            if runner.description == GameDiceFaces.runner.description {
                rolledRunners.append(dices[index])
            }
            index += 1
        }
        
        dices = rolledRunners
        return result
    }
    
    /// Remove dices from hand when the player finishes his turn
    func removeDicesFromHand() {
         self.dices = [Dice<GameDiceFaces>]()
    }
}
