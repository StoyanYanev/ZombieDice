public class InputHandeler {
    let MIN_NUMBER_OF_PLAYERS = 2
    let MAX_NUMBER_OF_PLAYERS = 8
    
    func createPlayers() throws -> [Player] {
        var players = [Player]()
        print("Enter number of players: ")
        let numberOfPlayers = Int(readLine()!)
        if numberOfPlayers! < MIN_NUMBER_OF_PLAYERS || numberOfPlayers! > MAX_NUMBER_OF_PLAYERS {
            throw InputError.invalidNumberOfPlayers
        }
        
        for _ in 0..<numberOfPlayers! {
            print("Enter player name: ")
            let currentPlayerName = readLine()
            players.append(Player(name: currentPlayerName!))
        }
        
        return players
    }
    
    func askPlayerForContinue() throws -> Bool {
        print("Do you want to continue: ")
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
