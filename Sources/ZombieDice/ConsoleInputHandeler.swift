public class ConsoleInputHandeler: InputHandeler {
    
    init() {}
    
    func createPlayers() throws -> [Player] {
        var players = [Zombie]()
        print("Enter number of players: ")
        let numberOfPlayers = Int(readLine()!)
        if numberOfPlayers! < InputHandelerConstants.MIN_NUMBER_OF_PLAYERS || numberOfPlayers! > InputHandelerConstants.MAX_NUMBER_OF_PLAYERS {
            throw InputError.invalidNumberOfPlayers
        }
        
        for _ in 0..<numberOfPlayers! {
            print("Enter player name: ")
            let currentPlayerName = readLine()
            players.append(Zombie(name: currentPlayerName!))
        }
        
        return players
    }
    
    func askPlayerForContinue(player: Player) throws -> Bool {
        print("\(player.name) do you want to continue: ")
        print("1. Yes")
        print("2. No")
        print("Your choice is: ")
        let choice = Int(readLine()!)
        if choice! < 1 || choice! > 2 {
            throw InputError.invalidChoice
        }
        
        return choice == 1 ? true : false
    }
}
