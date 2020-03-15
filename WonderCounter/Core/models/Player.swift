
import UIKit
import CoreData

@objc(Player)
class Player: NSManagedObject {
    
    @NSManaged public var name: String
    @NSManaged public var icon: String
    @NSManaged public var id: String
    
    @NSManaged public var scores: NSSet?
}
