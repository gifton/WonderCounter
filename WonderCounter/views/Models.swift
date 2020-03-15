

class WPlayer: Equatable {
    static func == (lhs: WPlayer, rhs: WPlayer) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name: String
    var scores: [WPlayerScore] = []
    
    init(name: String) {
        self.name = name
    }
    
    var totalScore: Int{
        
        var output = Int(0)
        
        for score in scores{
            output += score.score
        }
        
        return output
    }
}

struct WPlayerScore {
    var scoreType: ScoreType
    var score: Int
}

class NewGame {
    init(_ players: [WPlayer]) {
        self.players = players
    }
    
    var players: [WPlayer]
    
    var winner: Player?
    var scores: [WPlayer] = []
    
    func addScore(score: WPlayerScore, player: WPlayer) {
        if let currentplayer = players.filter({ $0 == player }).first {
            currentplayer.scores.append(score)
        }
    }
    func getWinner()-> WPlayer  {
        var current: WPlayer?
        var winning: Int = 0
        for player in players {
            if player.totalScore > winning {
                current = player
                winning = player.totalScore
            }
        }
        return current!
    }
}
