
import UIKit
import CoreData


class Game {
    @NSManaged public var id: String
    @NSManaged public var date: Date
    @NSManaged public var playerScores: NSSet
}


extension Game {
    var winner: Player {
        return Player()
    }
}
