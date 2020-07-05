final class Player {
    private var name: String
    private var points: Int
    
    init(name: String){
        self.name = name
        self.points = 0
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func getPoints() -> Int {
        return self.points
    }
    
    public func updatePoints(points: Int) {
        self.points += points
    }
}
