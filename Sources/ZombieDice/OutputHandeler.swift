import SwiftyTextTable

public class OutputHandeler {
    let TABLE_HEADER = "Players"
    let TABLE_WINNER_HEADER = "WINER"
    
    init(){}
    
    func prinResultTable(players: [Player]){
        let playerNames = players.map{$0.getName()}.map{TextTableColumn(header: $0)}
        let playerPoints = players.map{$0.getBrainScore()}
        
        var table = TextTable(columns: playerNames)
        table.header = TABLE_HEADER
        table.addRow(values: playerPoints)
        
        print(table.render())
    }
    
    func printPlayerTurn(player: Player) {
        print("\(player.getName()) it is your turn")
    }
    
    func printPlayerEndGame(player: Player) {
        print("\(player.getName()) you lost!")
    }
    
    func printWinner(player: Player) {
        var table = TextTable(columns: ["Name", "Points"].map{TextTableColumn(header: $0)})
        table.header = TABLE_WINNER_HEADER
        table.addRow(values: [player.getName(), player.getBrainScore()])
        
        print(table.render())
    }
}
