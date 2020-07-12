import SwiftyTextTable

public class ConsoleOutputHandeler: OutputHandeler {
    let TABLE_HEADER = "Players"
    let TABLE_WINNER_HEADER = "WINER"
    
    init(){}
    
    func prinResultTable(players: [Player]) {
        let playerNames = players.map{$0.name}.map{TextTableColumn(header: $0)}
        let playerPoints = players.map{$0.brainScore}
        
        var table = TextTable(columns: playerNames)
        table.header = TABLE_HEADER
        table.addRow(values: playerPoints)
        
        print(table.render())
    }
    
    func printPlayerTurn(player: Player) {
        print("\(player.name) it is your turn")
    }
    
    func printPlayerEndGame(player: Player) {
        print("\(player.name) you lost!")
    }
    
    func printWinner(player: Player) {
        var table = TextTable(columns: ["Name", "Points"].map{TextTableColumn(header: $0)})
        table.header = TABLE_WINNER_HEADER
        table.addRow(values: [player.name, player.brainScore])
        
        print(table.render())
    }
}
