public class Hand {
    private var dices: [Dice<GameDiceFaces>]
    
    init(){
        self.dices = [Dice<GameDiceFaces>]()
    }
    
    func rollDices(pulledDices: Array<Dice<GameDiceFaces>>) -> [GameDiceFaces] {
        dices = dices + pulledDices;
        let result = dices.map{$0.roll()}
        var rolledRunners = [Dice<GameDiceFaces>]()
        var index = 0
        for runner in result {
            if runner.description == GameDiceFaces.runner.description {
                rolledRunners.append(dices[index])
            }
            index += 1
        }
        
        dices = rolledRunners
        return result
    }
}
