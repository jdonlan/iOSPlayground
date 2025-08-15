import Foundation
import RealmSwift

class LorcanaCardRepository: LorcanaCardRepositoryProtocol {
    private let realmManager: RealmManager
    private let apiService: LorcanaAPIServiceProtocol
    
    private var realm: Realm {
        return realmManager.getRealm()
    }
    
    init(realmManager: RealmManager = RealmManager.shared, 
         apiService: LorcanaAPIServiceProtocol = LorcanaAPIService()) {
        self.realmManager = realmManager
        self.apiService = apiService
    }
    
    @MainActor func getAllCards() async -> [LorcanaCard] {
        let realmCards = realm.objects(LorcanaCardRealm.self)
        return Array(realmCards.map { $0.toLorcanaCard() })
    }
    
    @MainActor func getCards(by franchise: String) async -> [LorcanaCard] {
        let realmCards = realm.objects(LorcanaCardRealm.self)
            .filter("franchise == %@", franchise)
        return Array(realmCards.map { $0.toLorcanaCard() })
    }
    
    @MainActor func getCard(by uniqueID: String) async -> LorcanaCard? {
        guard let realmCard = realm.object(ofType: LorcanaCardRealm.self, forPrimaryKey: uniqueID) else {
            return nil
        }
        return realmCard.toLorcanaCard()
    }
    
    @MainActor func saveCards(_ cards: [LorcanaCard]) async throws {
        let realmCards = cards.map { LorcanaCardRealm(from: $0) }
        
        try realm.write {
            realm.add(realmCards, update: .modified)
        }
    }
    
    @MainActor func clearAllCards() async throws {
        try realm.write {
            realm.delete(realm.objects(LorcanaCardRealm.self))
        }
    }
    
    @MainActor func getCardCount() async -> Int {
        return realm.objects(LorcanaCardRealm.self).count
    }
    
    func syncCards() async throws {
        do {
            let cards = try await apiService.fetchCards()
            try await saveCards(cards)
            print("✅ Successfully synced \(cards.count) Lorcana cards")
        } catch {
            print("❌ Failed to sync cards: \(error.localizedDescription)")
            throw error
        }
    }
}

// MARK: - Repository Extensions for Convenience
extension LorcanaCardRepository {
    @MainActor func getCardsByRarity(_ rarity: String) async -> [LorcanaCard] {
        let realmCards = realm.objects(LorcanaCardRealm.self)
            .filter("rarity == %@ OR rarity == %@", rarity, rarity.capitalized)
        return Array(realmCards.map { $0.toLorcanaCard() })
    }
    
    @MainActor func getCardsByColor(_ color: String) async -> [LorcanaCard] {
        let realmCards = realm.objects(LorcanaCardRealm.self)
            .filter("color CONTAINS[c] %@", color)
        return Array(realmCards.map { $0.toLorcanaCard() })
    }
    
    @MainActor func getCharacterCards() async -> [LorcanaCard] {
        let realmCards = realm.objects(LorcanaCardRealm.self)
            .filter("type == 'Character'")
        return Array(realmCards.map { $0.toLorcanaCard() })
    }
    
    @MainActor func searchCards(by name: String) async -> [LorcanaCard] {
        let realmCards = realm.objects(LorcanaCardRealm.self)
            .filter("name CONTAINS[c] %@", name)
        return Array(realmCards.map { $0.toLorcanaCard() })
    }
}