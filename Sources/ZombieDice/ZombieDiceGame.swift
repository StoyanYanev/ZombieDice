public class ZombieDiceGame {
    let START_DICES_IN_GAME = 3
    let ALLOWED_SHOTGUNS_IN_ROUND = 3
    let NUMBER_OF_BRAINS_FOR_WINNING = 13
    
    private var players: [Player]
    private var cup: Cup
    private var inputHandeler: ConsoleInputHandeler
    private var outputHandeler: ConsoleOutputHandeler
    
    init() {
        self.players = [Zombie]()
        self.cup = Cup()
        self.inputHandeler = ConsoleInputHandeler()
        self.outputHandeler = ConsoleOutputHandeler()
    }
    
    /// The main game method which calls the other methods for reading the players input and printhing the game details.
    /// Each player pulls and rolls dices and chooses if he wants to continue his turn. The game ends when one of the
    /// players gets 13 brains. A player looses the game when he gets 3 shotguns during one turn.
    ///
    /// - Throws: InvalidNumberOfPlayers
    ///           InvalidChoice
    func play() throws {
        try self.players = inputHandeler.createPlayers()
        outputHandeler.printNewLine()
        var hasWinner = false
        var winner = Zombie(name: "")
        var removedPlayers = [Zombie]()
        while !hasWinner {
            for player in players {
                outputHandeler.printPlayerTurn(player: player)
                try playRounds(player: player as! Zombie)
                if player.shotgunScore >= ALLOWED_SHOTGUNS_IN_ROUND {
                    outputHandeler.printPlayerEndGame(player: player)
                    removedPlayers.append(player as! Zombie)
                }
                if player.brainScore == NUMBER_OF_BRAINS_FOR_WINNING || (players.count - removedPlayers.count) == 1 {
                    winner = player as! Zombie
                    if (players.count - removedPlayers.count) == 1 {
                        winner = players.filter{!removedPlayers.contains($0 as! Zombie)}[0] as! Zombie
                    }
                    
                    hasWinner = true
                    outputHandeler.printWinner(player: winner)
                    break
                }
                player.resetNumberOfShotguns()
                player.hand.removeDicesFromHand()
                cup.returnDicesInCup()
                outputHandeler.prinResultTable(players: players)
                outputHandeler.printNewLine()
            }
            players = players.filter{!removedPlayers.contains($0 as! Zombie)}
            removedPlayers = [Zombie]()
        }
    }
    
    /// Reprents one player's turn. The current player which is passed as parameter pulls and roles dices
    /// and then decides if wants to continue the turn
    ///
    /// - Parameters: player - the current player
    /// - Throws: InvalidChoice
    internal func playRounds(player: Zombie) throws {
        var isContinue = true
        var numberOfRolledRunners = 0
        while isContinue && player.shotgunScore < ALLOWED_SHOTGUNS_IN_ROUND {
            let pulledDices = cup.pullDices(START_DICES_IN_GAME - numberOfRolledRunners)
            let rolledDices = player.hand.rollDices(pulledDices: pulledDices)
            let numberOfFaces = countNumberOfFaces(faces: rolledDices)
            numberOfRolledRunners = numberOfFaces.numberOfRunners
            printRolledFaces(numberOfBrains: numberOfFaces.numberOfBrains, numberOfShotguns: numberOfFaces.numberOfShotguns, numberOfRunners: numberOfRolledRunners)
            updatePlayerPoints(player: player, numberOfBrains: numberOfFaces.numberOfBrains, numberOfShotguns: numberOfFaces.numberOfShotguns)
            if player.brainScore == NUMBER_OF_BRAINS_FOR_WINNING || player.shotgunScore >= ALLOWED_SHOTGUNS_IN_ROUND {
                break
            }
            isContinue = try inputHandeler.askPlayerForContinue(player: player)
        }
    }
    
    /// Returns the number of the number of brains, the number of shotguns and the number of runners from the rolled dices
    ///
    /// - Parameters: faces - an array with the faces from the rolled dices
    /// - Returns: the number of brains, the number of shotguns and the number of runners from the rolled dices
    internal func countNumberOfFaces(faces: [GameDiceFaces]) -> (numberOfBrains: Int, numberOfShotguns: Int, numberOfRunners: Int) {
        let numberOfBrains = faces.filter{$0.description == GameDiceFaces.brains.description}.count
        let numberOfShotguns = faces.filter{$0.description == GameDiceFaces.shotgun.description}.count
        let numberOfRunners = faces.filter{$0.description == GameDiceFaces.runner.description}.count
        
        return (numberOfBrains, numberOfShotguns, numberOfRunners)
    }
    
    /// Prints the faces of  the rolled dices
    ///
    /// - Parameters: numberOfBrains
    ///               numberOfShotguns
    ///               numberOfRunners
    internal func printRolledFaces(numberOfBrains: Int, numberOfShotguns: Int, numberOfRunners: Int) {
        print("Rolled \(GameDiceFaces.brains.description) \(numberOfBrains); \(GameDiceFaces.shotgun.description) \(numberOfShotguns); \(GameDiceFaces.runner.description) \(numberOfRunners)")
    }
    
    /// Updates the player braina and shotguns score with the number of brains and number of shotguns from the rolled dices
    ///
    /// - Parameters: player - the current player
    ///               numberOfBrains
    ///               numberOfShotguns
    internal func updatePlayerPoints(player: Zombie, numberOfBrains: Int, numberOfShotguns: Int) {
        player.updateBrainScore(numberOfBrains: numberOfBrains)
        player.updateNumberOfShotguns(numberOfShotguns: numberOfShotguns)
    }
}
