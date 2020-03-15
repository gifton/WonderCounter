
import UIKit
import CoreData


@objc(PlayerScore)
class PlayerScore: NSManagedObject {
    
    @NSManaged public var war: Int16
    @NSManaged public var coin: Int16
    @NSManaged public var wonder: Int16
    @NSManaged public var civilian: Int16
    @NSManaged public var commercial: Int16
    @NSManaged public var guild: Int16
    @NSManaged public var science: Int16
    
    @NSManaged public var player: Player
    
}

extension PlayerScore {
    var totoalScore: Int {
        return Int(war + coin + wonder + civilian + commercial + guild + science)
    }
}
