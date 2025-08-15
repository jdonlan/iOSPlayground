import Foundation
import RealmSwift

// Simple test class to verify Realm is working
class RealmConnectionTest {
    static func testConnection() {
        do {
            let realm = try Realm()
            print("✅ Realm connection successful!")
            print("📁 Database location: \(realm.configuration.fileURL?.absoluteString ?? "Unknown")")
        } catch {
            print("❌ Realm connection failed: \(error.localizedDescription)")
        }
    }
}