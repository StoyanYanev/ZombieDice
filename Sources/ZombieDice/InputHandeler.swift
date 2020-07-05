enum InputError: Error, CustomStringConvertible {
    case invalidNumberOfPlayers
    
    var description: String {
        switch self {
        case .invalidNumberOfPlayers:
            return "The number of players must be between 2-8!"
        }
    }
}

final class InputHandeler {
    let MIN_NUMBER_OF_PLAYERS = 2
    let MAX_NUMBER_OF_PLAYERS = 8
    
    func createPlayers() throws -> [Player] {
        var players = [Player]()
        print("Enter number of players: ")
        let numberOfPlayers = Int(readLine()!)
        if  numberOfPlayers != MIN_NUMBER_OF_PLAYERS || numberOfPlayers != MAX_NUMBER_OF_PLAYERS {
            throw InputError.invalidNumberOfPlayers
        }
        
        for _ in 0..<numberOfPlayers! {
            print("Enter player name: ")
            let currentPlayerName = readLine()
            players.append(Player(name: currentPlayerName!))
        }
        
        return players
    }
}
