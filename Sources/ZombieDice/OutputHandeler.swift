import SwiftyTextTable

final class OutputHandeler {
    let TABLE_HEADER = "Players"
    
    private var players: [Player]
    
    init(players: [Player]){
        self.players = players
    }
    
    func drawResult(){
        let playerNames = self.players.map{$0.getName()}.map{TextTableColumn(header: $0)}
        let playerPoints = self.players.map{$0.getPoints()}
        
        var table = TextTable(columns: playerNames)
        table.header = TABLE_HEADER
        table.addRow(values: playerPoints)
        
        print(table.render())
    }
}
