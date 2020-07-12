/// Enum which represents the faces that one dice can have
enum GameDiceFaces: String, CustomStringConvertible, Hashable, Equatable {
    case brains = "🧠"
    case shotgun = "💥"
    case runner = "👣"
    
    var description: String {
        get {
            return self.rawValue
        }
    }
}
