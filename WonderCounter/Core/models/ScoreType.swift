
enum ScoreType: String {
    case war = "Military"
    case coins = "Treasury"
    case wonders = "Wonders"
    case civilian = "Civilian Structures"
    case commercial = "Commercial Structures"
    case guilds = "Guilds"
    case science = "Science"
    
    static var ordered: [ScoreType] {
        return [.war, .coins, .wonders, .civilian, .science, .commercial, .guilds]
    }
    
    static func next(_ current: ScoreType) -> ScoreType {
        if let idx = ScoreType.ordered.firstIndex(of: current) {
            return ScoreType.ordered[idx + 1]
        }
        
        return .war
    }
}

enum ScoreColor: String {
    case war = "BD252C"
    case coins = "E6762B"
    case wonders = "202020"
    case civilian =  "263877"
    case science =  "007C40"
    case commercial =  "933D03"
    case guilds =  "43134C"
    
    static var ordered: [ScoreColor] {
        return [.war, .coins, .wonders, .civilian, .science, .commercial, .guilds]
    }
}
