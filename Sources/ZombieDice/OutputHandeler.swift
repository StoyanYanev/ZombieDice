protocol OutputHandeler {
    func prinResultTable(players: [Player])
    func printPlayerTurn(player: Player)
    func printPlayerEndGame(player: Player)
    func printWinner(player: Player)
    func printNewLine()
}
