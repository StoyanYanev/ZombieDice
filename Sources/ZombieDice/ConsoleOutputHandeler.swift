import SwiftyTextTable

/// The purpose of the OutputHandler is to print details during the game
/// It uses SwiftyTextTable in order to make the visualization more user friendly
public class ConsoleOutputHandeler: OutputHandeler {
    let TABLE_HEADER = "Players"
    let TABLE_WINNER_HEADER = "WINER"
    
    init(){}
    
    /// Prints table with the game results
    ///
    /// - Parameters: players - the game players
    func prinResultTable(players: [Player]) {
        let playerNames = players.map{$0.name}.map{TextTableColumn(header: $0)}
        let playerPoints = players.map{$0.brainScore}
        
        var table = TextTable(columns: playerNames)
        table.header = TABLE_HEADER
        table.addRow(values: playerPoints)
        
        print(table.render())
    }
    
    /// Prints which player's turn is
    ///
    /// - Parameters: player - the current player
    func printPlayerTurn(player: Player) {
        print("\(player.name) it is your turn")
    }
    
    /// Prints message when a player looses the game
    ///
    /// - Parameters: player - the player who has lost the game
    func printPlayerEndGame(player: Player) {
        print("\(player.name) you lost!")
    }
    
    /// Prints message when a player wins the game
    ///
    /// - Parameters: player - the player that has won the game
    func printWinner(player: Player) {
        var table = TextTable(columns: ["Name", "Points"].map{TextTableColumn(header: $0)})
        table.header = TABLE_WINNER_HEADER
        table.addRow(values: [player.name, player.brainScore])
        
        print(table.render())
    }
    
    func printNewLine() {
        print("\n")
    }
}
