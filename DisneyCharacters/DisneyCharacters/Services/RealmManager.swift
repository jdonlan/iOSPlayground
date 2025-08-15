import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    private let realm: Realm
    
    private init() {
        do {
            // Configure Realm with proper settings
            let config = Realm.Configuration(
                schemaVersion: 1,
                migrationBlock: { migration, oldSchemaVersion in
                    // Handle migrations if needed in the future
                    if oldSchemaVersion < 1 {
                        // Migration logic goes here
                    }
                }
            )
            Realm.Configuration.defaultConfiguration = config
            
            self.realm = try Realm()
            print("✅ RealmManager initialized successfully")
        } catch {
            fatalError("❌ Failed to initialize RealmManager: \(error.localizedDescription)")
        }
    }
    
    func getRealm() -> Realm {
        return realm
    }
}