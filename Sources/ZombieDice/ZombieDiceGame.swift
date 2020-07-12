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
    
    func play() throws {
        try self.players = inputHandeler.createPlayers()
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
                cup.returnDicesInCup()
                outputHandeler.prinResultTable(players: players)
            }
            players = players.filter{!removedPlayers.contains($0 as! Zombie)}
            removedPlayers = [Zombie]()
        }
    }
    
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
    
    internal func countNumberOfFaces(faces: [GameDiceFaces]) -> (numberOfBrains: Int, numberOfShotguns: Int, numberOfRunners: Int) {
        let numberOfBrains = faces.filter{$0.description == GameDiceFaces.brains.description}.count
        let numberOfShotguns = faces.filter{$0.description == GameDiceFaces.shotgun.description}.count
        let numberOfRunners = faces.filter{$0.description == GameDiceFaces.runner.description}.count
        
        return (numberOfBrains, numberOfShotguns, numberOfRunners)
    }
    
    internal func printRolledFaces(numberOfBrains: Int, numberOfShotguns: Int, numberOfRunners: Int) {
        print("Rolled \(GameDiceFaces.brains.description) \(numberOfBrains); \(GameDiceFaces.shotgun.description) \(numberOfShotguns); \(GameDiceFaces.runner.description) \(numberOfRunners)")
    }
    
    internal func updatePlayerPoints(player: Zombie, numberOfBrains: Int, numberOfShotguns: Int) {
        player.updateBrainScore(numberOfBrains: numberOfBrains)
        player.updateNumberOfShotguns(numberOfShotguns: numberOfShotguns)
    }
}
