protocol InputHandeler {
    func createPlayers() throws -> [Player]
    func askPlayerForContinue(player: Player) throws -> Bool
}
