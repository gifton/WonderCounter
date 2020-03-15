
import CoreData

// MARL: NSManagedObject helper methods
extension NSManagedObjectContext {

    // insert single object into MOC after object materialized manually (usually after user-creation)
    func insertObject<A: NSManagedObject>() -> A where A: Managed {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else { fatalError("Wrong object type") }
        return obj
    }
    
    // safe-save for CoreData
    // use case i.e: User does not have enough allocated memory remaining on disk to save item
    func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            print("unable to save data... rolling back")
            rollback()
            return false
        }
    }
    
    // safe saving method with returning (Bool) method for translation in DM or Controllers
    func performChanges(block: @escaping (Bool) -> ()) {
        perform {
            block(self.saveOrRollback())
        }
    }
    
}


// container for loading aplpication into Core data context
// Container creation is application-leve and should encapsulate window initialization && AppCoordinator.start() methods
func createWonderContainer(completion: @escaping (NSPersistentContainer) -> Void) {
    
    let container = NSPersistentContainer(name: "WonderModel")
    
    container.loadPersistentStores { (_, error) in
        
        guard error == nil else { fatalError("failed to load store: \(error!)")}
        
        DispatchQueue.main.async { completion(container) }
    }
    
}

